var altoPantalla = 304; /* Alto de la zona de juego.

/** target frames per second  
    @type Number
*/
var FPS = 30;
/** time between frames 
    @type Number
*/
var SECONDS_BETWEEN_FRAMES = 1 / FPS;
/** A global reference to the GameObjectManager instance  
    @type GameObjectManager
*/
var g_GameObjectManager = null;
/** An image to be used by the application
    @type Image
*/
var g_run_left = new Image();
g_run_left.src = "run_left.png";
/** An image to be used by the application
    @type Image
*/
var g_run_right = new Image();
g_run_right.src = "run_right.png";
/** An image to be used by the application
    @type Image
*/
var g_idle_left = new Image();
g_idle_left.src = "idle_left.png";
/** An image to be used by the application
    @type Image
*/
var g_idle_right = new Image();
g_idle_right.src = "idle_right.png";
/** An image to be used by the application
    @type Image
*/
var g_back0 = new Image();
g_back0.src = "jsplatformer4_b0.png";
/** An image to be used by the application
    @type Image
*/
var g_back1 = new Image();
g_back1.src = "plano1.png";
/** An image to be used by the application
    @type Image
*/
var g_back2 = new Image();
g_back2.src = "plano2.png";
/** An image to be used by the application
    @type Image
*/
var g_block = new Image();
g_block.src = "BlockA0.png";

var g_hud = new Image();
g_hud.src = "hud.png";

// The entry point of the application is set to the init function
window.onload = init;

/**
    Application entry point
*/
function init()
{
    new GameObjectManager().startupGameObjectManager();
}