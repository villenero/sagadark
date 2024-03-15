/**
    A class to represent the level
    @author <a href="mailto:matthewcasperson@gmail.com">Matthew Casperson</a>
    @class
*/
function Level()
{
    this.blocks = new Array();
    this.blockWidth = 64;
    this.blockHeight = 32;

    /**
        Initialises this object
    */
    this.startupLevel = function()
    {
        this.blocks = [ 1, 1, 1, 1, 1, 1, 1, 1,
        								1, 1, 1, 1, 1, 1, 1, 1,
        								1, 1, 2, 3, 2, 2, 1, 1,
        								1, 1, 1, 1, 1, 1, 1, 1,
        								1, 1, 1, 1, -10, -10,-10];

        this.addBlocks();

        return this;
    }

    /**
        Adds the blocks to the screen by creating VisualGameObjects
    */
    this.addBlocks = function()
    {
        for (var x = 0; x < this.blocks.length; ++x)
        {
            for (var y = 0; y < this.blocks[x]; ++y)
            {
                new VisualGameObject().startupVisualGameObject(g_block, x * this.blockWidth, altoPantalla - (y + 1) * this.blockHeight, 4);
            }
        }
    }

    /**
        @return     The block under the specified x position
        @param x    The x position to test
    */
    this.currentBlock = function(x)
    {
        return parseInt( x / this.blockWidth);
    }
    
    /**
        @return             The hieght of the ground under the specified block
        @param blockIndex   The block number
    */
    this.groundHeight = function(blockIndex)
    {
        if (blockIndex < 0 || blockIndex > this.blocks.length) return 0;

        return this.blocks[blockIndex] *  this.blockHeight;
    }
}