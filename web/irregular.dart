import 'package:stagexl/stagexl.dart';

class Irregular extends Bitmap implements Animatable {
  num vx, vy;
  num oldX,oldY;
  num diffX,diffY;
  bool alive = false;
  bool movingLeft = false;
  bool movingRight = false;
  bool movingUp = false;
  bool movingDown = false;
  List<Point> points = [new Point(32, 4), new Point(51, 40), new Point(36, 60),
      new Point(4, 31)];
  Polygon poly;

  Irregular(BitmapData bitmapData, {int vx, int vy, int x, int y})
      : super(bitmapData) {
    //pivotX = bitmapData.width / 2;
    //pivotY = bitmapData.height / 2;
    poly = new Polygon(points);
    this.x = x;    
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    poly.points.forEach((point) {
      point.x += this.x;
      point.y += this.y;
    });

  }


  @override
  bool advanceTime(num time) {
    // TODO: implement advanceTime
    oldX = x;
    oldY = y;
    
    if (movingLeft) {
      x = x - vx * time;
    } else if (movingRight) {
      x = x + vx * time;
    }
    if (movingUp) {
      y = y - vy * time;
    } else if (movingDown) {
      y = y + vy * time;
    }
    
    diffX = x - oldX;
    diffY = y - oldY;
    
    poly.points.forEach((point) {
      point.x += diffX;
      point.y += diffY;
    });
    return true;

  }
}
