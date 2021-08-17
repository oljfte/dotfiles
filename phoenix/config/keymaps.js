// Move window
Key.on("j", PRIMARY_MODIFIER, () => moveWindowStepwisely("y", 1));
Key.on("k", PRIMARY_MODIFIER, () => moveWindowStepwisely("y", -1));
Key.on("h", PRIMARY_MODIFIER, () => moveWindowStepwisely("x", -1));
Key.on("l", PRIMARY_MODIFIER, () => moveWindowStepwisely("x", 1));

// Move focus
Key.on("h", SECONDARY_MODIFIER, () => focusClosestInDirection("west"));
Key.on("j", SECONDARY_MODIFIER, () => focusClosestInDirection("south"));
Key.on("k", SECONDARY_MODIFIER, () => focusClosestInDirection("north"));
Key.on("l", SECONDARY_MODIFIER, () => focusClosestInDirection("east"));

// Maximise
Key.on("f", PRIMARY_MODIFIER, () => maximizeWindow());

// Restore all
Key.on("space", PRIMARY_MODIFIER, () => restoreAllWindows(WINDOW_ARRANGEMENT));
