package;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';
	
	public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;
	
	public var offsetX = 0;
	public var offsetY = 0;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
		    offsetX = 0;
			offsetY = 0;
			switch (char) {
			    case 'scott':
					// taken from hypnos code sory Plsss I DONT PUT ME IN JAIL :sob:
				    var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/Scott Animated');
					frames = file;
					
					animation.addByPrefix(char, 'Scott Icon', 23, true);
					animation.play(char);
					
					offsetY = 12;
					offsetX = -8;
		default:
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			loadGraphic(file); //Load stupidly first for getting the file size
			loadGraphic(file, true, Math.floor(width / 3), Math.floor(height)); //Then load it fr
			iconOffsets[0] = (width - 150) / 3;
			iconOffsets[1] = (width - 150) / 3;
			iconOffsets[2] = (width - 150) / 3;
			updateHitbox();

			animation.add(char, [0, 1, 2], 0, false, isPlayer);
			animation.play(char);
			updateHitbox();
			}
			this.char = char;

			updateHitbox();
			if (char == 'scott') {
				setGraphicSize(Std.int(width * 0.3));
				updateHitbox();
			}
			initialWidth = width;
			initialHeight = height;
		
			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
		    }
	    }
    }
	
	public function getCharacter():String {
		return char;
	}
}