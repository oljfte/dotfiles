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

const WINDOW_ARRANGEMENT = [
  // TODO: Multiple patterns
  // Space 1
  {
    name: "TweetDeck",
    gridFrame: { x: 0, y: 0, width: 3, height: 6 },
    spaceIndex: 1,
  },
  {
    name: "Spotify",
    gridFrame: { x: 0, y: 6, width: 3, height: 6 },
    spaceIndex: 1,
  },
  {
    name: "Calendar",
    gridFrame: { x: 3, y: 0, width: 5, height: 12 },
    spaceIndex: 1,
  },
  {
    name: "Mail",
    gridFrame: { x: 8, y: 0, width: 4, height: 6 },
    spaceIndex: 1,
  },
  {
    name: "Slack",
    gridFrame: { x: 8, y: 6, width: 4, height: 6 },
    spaceIndex: 1,
  },

  // Space 2
  {
    name: "Google Chrome",
    gridFrame: { x: 0, y: 0, width: 4, height: 12 },
    spaceIndex: 2,
  },
  {
    name: "Term",
    gridFrame: { x: 4, y: 0, width: 8, height: 12 },
    spaceIndex: 2,
  },
];
