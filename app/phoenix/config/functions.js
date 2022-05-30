const moveWindowToAdjacentSpace = (
  direction,
  { targetWindow = Window.focused(), focus = true }
) => {
  const allSpaces = Space.all();
  const currentSpace = Space.active();
  const currentIndex = allSpaces.findIndex(
    (s) => s.hash() == currentSpace.hash()
  );
  if (!(targetWindow && currentSpace && currentIndex != -1)) return;

  let targetSpace;
  if (direction == "right") {
    targetSpace = allSpaces[currentIndex + 1];
  } else if (direction == "left") {
    targetSpace = allSpaces[currentIndex - 1];
  }

  targetSpace.moveWindows([targetWindow]);

  if (focus) {
    targetWindow.focus();
  }
};

const getWindowCenterCoordinate = (targetWindow = Window.focused()) => {
  if (!targetWindow) return;

  return {
    x: targetWindow.topLeft().x + targetWindow.size().width / 2,
    y: targetWindow.topLeft().y + targetWindow.size().height / 2,
  };
};

const getPaddedFrameForWindow = (targetWindow = Window.focused()) => {
  const frame = targetWindow.screen().frame();
  return {
    width: frame.width - PADDING,
    height: frame.height - PADDING - MENUBAR_HEIGHT,
  };
};

const getWindowGrid = (targetWindow = Window.focused()) => {
  const frame = getPaddedFrameForWindow();

  const currentGridX = GRID.x.findIndex(
    (vec) =>
      Math.abs(vec.origin * frame.width + PADDING - targetWindow.topLeft().x) <
        POSITION_TORELANCE &&
      Math.abs(vec.range * frame.width - PADDING - targetWindow.size().width) <
        2 * POSITION_TORELANCE
  );
  const currentGridY = GRID.y.findIndex(
    (vec) =>
      Math.abs(
        vec.origin * frame.height +
          PADDING -
          targetWindow.topLeft().y +
          MENUBAR_HEIGHT
      ) < POSITION_TORELANCE &&
      Math.abs(
        vec.range * frame.height - PADDING - targetWindow.size().height
      ) <
        2 * POSITION_TORELANCE
  );

  return {
    x: currentGridX,
    y: currentGridY,
  };
};

const getWindowNearestGrid = (targetWindow = Window.focused()) => {
  const center = getWindowCenterCoordinate(targetWindow);
  const frame = getPaddedFrameForWindow();

  return {
    // NOTE: Just split evenly for now. Might be adjusted to actual GRID.
    x: Math.floor((center.x / frame.width) * GRID_X_PATTERNS),
    y: Math.floor((center.y / frame.height) * GRID_Y_PATTERNS),
  };
};

const moveWindowToGrid = (xIndex, yIndex, targetWindow = Window.focused()) => {
  const frame = getPaddedFrameForWindow();

  if (!(targetWindow && frame)) return;

  const currentOrigin = targetWindow.topLeft();
  const currentSize = targetWindow.size();

  targetWindow.setTopLeft({
    x:
      xIndex !== null
        ? frame.width * GRID.x[xIndex].origin + PADDING
        : currentOrigin.x,
    y:
      yIndex !== null
        ? frame.height * GRID.y[yIndex].origin + MENUBAR_HEIGHT + PADDING
        : currentOrigin.y,
  });

  targetWindow.setSize({
    width:
      xIndex !== null
        ? frame.width * GRID.x[xIndex].range - PADDING
        : currentSize.width,
    height:
      yIndex !== null
        ? frame.height * GRID.y[yIndex].range - PADDING
        : currentSize.height,
  });
};

const focusClosestInDirection = (direction) => {
  const previousWindow = Window.focused();
  if (!previousWindow) return;

  let res;
  let currentWindow = previousWindow;

  for (let i = 0; i < 10; i++) {
    res = currentWindow.focusClosestNeighbor(direction);
    if (!res) break;

    currentWindow = Window.focused();
    if (currentWindow.isVisible()) {
      return true;
    }
  }

  if (currentWindow.isVisible()) return true;

  previousWindow.focus();
};

const maximizeWindow = (targetWindow = Window.focused()) => {
  if (!targetWindow) return;
  targetWindow.maximise();
};

const moveWindowStepwisely = (axis, step, targetWindow = Window.focused()) => {
  if (!(axis && step && targetWindow)) return;

  const gridPatterns = eval("GRID_" + axis.toUpperCase() + "_PATTERNS");

  let currentGrid = getWindowGrid(targetWindow)[axis];

  if (currentGrid == -1) {
    currentGrid = getWindowNearestGrid(targetWindow)[axis];
  }

  const nextGrid = (currentGrid + step + gridPatterns) % gridPatterns;

  if (axis == "x") {
    if (currentGrid + step < 0) {
      moveWindowToAdjacentSpace("left", { targetWindow: targetWindow });
    } else if (currentGrid + step >= gridPatterns) {
      moveWindowToAdjacentSpace("right", { targetWindow: targetWindow });
    }
    moveWindowToGrid(nextGrid, null, targetWindow);
  } else if (axis == "y") {
    if (currentGrid + step < 0 || currentGrid + step >= gridPatterns) {
      return;
    }
    moveWindowToGrid(null, nextGrid, targetWindow);
  }
};

const moveWindowToSpace = (
  spaceIndex,
  targetWindow = Window.focused(),
  focus = false
) => {
  const normalSpaces = Space.all().filter((space) => space.isNormal());
  normalSpaces[spaceIndex - 1].moveWindows([targetWindow]);
  if (!focus) return;
  targetWindow.focus();
};

const getAppByName = (appName) => {
  App.launch(appName, { focus: true });

  return App.get(appName);
};

const restoreWindow = (name, gridFrame, spaceIndex) => {
  const targetApp = getAppByName(name);

  if (!targetApp) return;

  if (targetApp.name() != name) return;

  const targetAppWindows = _.compact(
    [targetApp.windows()].concat([targetApp.mainWindow()]).flat()
  ).filter((targetAppWindow) => targetAppWindow.isVisible());

  if (targetAppWindows.length == 0) {
    targetApp.terminate({ force: true });
    return;
  }

  const results = targetAppWindows.map((targetWindow) => {
    const frame = getPaddedFrameForWindow();
    const screenWidth = frame.width;
    const screenHeight = frame.height;

    const destinationFrame = {
      y: Math.floor(
        (gridFrame.y * screenHeight) / 12 + PADDING + MENUBAR_HEIGHT
      ),
      x: Math.floor((gridFrame.x * screenWidth) / 12 + PADDING),
      width: Math.floor((gridFrame.width * screenWidth) / 12 - PADDING),
      height: Math.floor((gridFrame.height * screenHeight) / 12 - PADDING),
    };

    targetWindow.setFrame(destinationFrame);
    moveWindowToSpace(spaceIndex, targetWindow);

    const isPositionCorrect = !Object.keys(destinationFrame)
      .map((key) => {
        return (
          Math.abs(targetWindow.frame()[key] - destinationFrame[key]) <
          POSITION_TORELANCE
        );
      })
      .includes(false);

    const isSpaceCorrect =
      targetWindow.spaces().length == 1 &&
      targetWindow.spaces()[0].hash() == Space.all()[spaceIndex - 1].hash();

    return isPositionCorrect && isSpaceCorrect;
  });

  return results.length > 0 && !results.includes(false);
};

const restoreAllWindows = (configs, iteration = RESTORING_ITERATION) => {
  const currentFocusedWindow = Window.focused();

  const iteratedConfig = Array.from(
    { length: iteration },
    () => configs
  ).flat(); //HACK

  let completedApps = [];
  iteratedConfig.reduce((chain, config) => {
    return chain.then(async () => {
      await new Promise((resolve) => {
        if (completedApps.includes(config.name)) {
          resolve();
        } else {
          setTimeout(() => {
            const isCurrentAppCompleted = restoreWindow(
              config.name,
              config.gridFrame,
              config.spaceIndex
            );
            if (isCurrentAppCompleted) {
              completedApps.push(config.name);
            }

            const isEveryAppCompleted =
              _.uniq(completedApps).length == configs.length;

            if (isEveryAppCompleted) {
              currentFocusedWindow.focus();
            }

            resolve();
          }, RESTORING_INTERVAL);
        }
      });
    });
  }, Promise.resolve());
};
