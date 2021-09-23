// Modifier
const PRIMARY_MODIFIER = ["ctrl", "cmd"];
const SECONDARY_MODIFIER = ["ctrl", "alt"];

// Padding
const MENUBAR_HEIGHT = 0;
const PADDING = 50;
const POSITION_TORELANCE = 30;

// Grid
const GRID = {
  x: [
    { origin: 0, range: 1 / 3 },
    { origin: 0, range: 1 / 2 },
    { origin: 0, range: 2 / 3 },
    { origin: 1 / 3, range: 1 / 3 },
    { origin: 1 / 3, range: 2 / 3 },
    { origin: 1 / 2, range: 1 / 2 },
    { origin: 2 / 3, range: 1 / 3 },
  ],
  y: [
    { origin: 0, range: 1 / 2 },
    { origin: 0, range: 1 },
    { origin: 1 / 2, range: 1 / 2 },
  ],
};

const GRID_X_PATTERNS = GRID.x.length;
const GRID_Y_PATTERNS = GRID.y.length;

// Window restoration
const RESTORING_ITERATION = 20;
const RESTORING_INTERVAL = 200;
