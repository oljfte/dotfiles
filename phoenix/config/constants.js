// Modifier
const PRIMARY_MODIFIER = ["ctrl", "cmd"];
const SECONDARY_MODIFIER = ["ctrl", "alt"];

// Padding
const MENUBAR_HEIGHT = 25;
const PADDING = 0;
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
    name: "LINE",
    gridFrame: { x: 0, y: 0, width: 3, height: 6 },
    spaceIndex: 1,
  },
  {
    name: "Spotify",
    gridFrame: { x: 0, y: 6, width: 3, height: 6 },
    spaceIndex: 1,
  },
  {
    name: "TweetDeck",
    gridFrame: { x: 3, y: 0, width: 9, height: 12 },
    spaceIndex: 1,
  },

  // Space 2
  {
    name: "Calendar",
    gridFrame: { x: 0, y: 0, width: 4, height: 6 },
    spaceIndex: 2,
  },
  {
    name: "Mail",
    gridFrame: { x: 4, y: 0, width: 4, height: 6 },
    spaceIndex: 2,
  },
  {
    name: "Finder",
    gridFrame: { x: 8, y: 0, width: 4, height: 6 },
    spaceIndex: 2,
  },
  {
    name: "Timing",
    gridFrame: { x: 0, y: 6, width: 5, height: 6 },
    spaceIndex: 2,
  },
  {
    name: "Reminders",
    gridFrame: { x: 5, y: 6, width: 3, height: 6 },
    spaceIndex: 2,
  },
  {
    name: "Notes",
    gridFrame: { x: 8, y: 6, width: 4, height: 6 },
    spaceIndex: 2,
  },

  // Space 3
  {
    name: "Google Chrome",
    gridFrame: { x: 0, y: 0, width: 4, height: 6 },
    spaceIndex: 3,
  },
  {
    name: "Slack",
    gridFrame: { x: 0, y: 6, width: 4, height: 6 },
    spaceIndex: 3,
  },
  {
    name: "Terminal",
    gridFrame: { x: 4, y: 0, width: 8, height: 12 },
    spaceIndex: 3,
  },
];