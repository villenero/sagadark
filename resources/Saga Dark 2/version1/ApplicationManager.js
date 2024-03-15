/**
    The ApplicationManager is used to manage the application itself.
    @author <a href="mailto:matthewcasperson@gmail.com">Matthew Casperson</a>
    @class
*/
function ApplicationManager()
{
    /**
        Initialises this object
        @return A reference to the initialised object
    */
    this.startupApplicationManager = function()
    {
    	this.hud = new VisualGameObject().startupVisualGameObject(g_hud,0,304,5);
		this.level = new Level().startupLevel();
				// coloca los planos de scroll: function(image, x, y, z, width, height, scrollFactor)
        this.background3 = new RepeatingGameObject().startupRepeatingGameObject(g_back2, 0, 0, 3, 512, 304, 1);
        this.background2 = new RepeatingGameObject().startupRepeatingGameObject(g_back1, 0, 0, 2, 512, 304, 0.5);
        this.background = new RepeatingGameObject().startupRepeatingGameObject(g_back0, 0, 0, 1, 512, 304, 0.25);
        this.runner = new Player().startupPlayer(this.level);
        
        
        
        /*
        var ctx = document.getElementById('canvas').getContext('2d');
    		ctx.drawImage(g_hud,0,304);
    		*/
    		
        return this;
    }
}