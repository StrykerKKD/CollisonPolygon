import 'dart:html';
import 'package:stagexl/stagexl.dart';
import 'irregular.dart';

void main() {
  Element canvas = querySelector('#stage');
  Stage stage = new Stage(canvas, webGL: true);
  RenderLoop renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  ResourceManager resourceManager = new ResourceManager();
  var mainColor = 0x7AA241;



  resourceManager..addBitmapData("irregular", "irregular2.png");

  resourceManager.load().then((_) {

    BitmapData backgroundBitmapData = new BitmapData(800, 600, false, mainColor
        );
    Bitmap backgroundBitmap = new Bitmap(backgroundBitmapData);
    stage.addChild(backgroundBitmap);

    Irregular player = new Irregular(resourceManager.getBitmapData("irregular"),
        x: 400, y: 500, vx: 100, vy: 100);
    Irregular block = new Irregular(resourceManager.getBitmapData("irregular"),
        x: 400, y: 300);

    stage.addChild(player);
    stage.addChild(block);
    stage.juggler.add(player);

    //print("Player's poly positions: ${player.poly.points}");
    //print("Block's poly positions: ${block.poly.points}");

    stage.focus = stage;

    const leftArrow = 37;
    const upArrow = 38;
    const rightArrow = 39;
    const downArrow = 40;

    stage.onKeyDown.listen((value) {

      switch (value.keyCode) {
        case leftArrow:
          player.movingLeft = true;
          break;
        case upArrow:
          player.movingUp = true;
          break;
        case rightArrow:
          player.movingRight = true;
          break;
        case downArrow:
          player.movingDown = true;
          break;
      }

    });


    stage.onKeyUp.listen((value) {

      switch (value.keyCode) {
        case leftArrow:
          player.movingLeft = false;
          break;
        case upArrow:
          player.movingUp = false;
          break;
        case rightArrow:
          player.movingRight = false;
          break;
        case downArrow:
          player.movingDown = false;
          break;
      }

    });

    int blockCount = 1;
    int playerCount = 1;
    stage.onEnterFrame.listen((_) {
      if (player.hitTestObject(block)) {
        block.poly.points.forEach((point) {
          if (player.poly.contains(point.x, point.y)) {
            print("Block Hit:$blockCount");
            blockCount++;
          }
        });
        player.poly.points.forEach((point) {
          if (block.poly.contains(point.x, point.y)) {
            print("Player Hit:$playerCount");
            playerCount++;
          }
        });
      }

    });

  });

}
