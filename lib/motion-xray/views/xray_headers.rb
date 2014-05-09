module Motion ; module Xray

  class XraySectionHeader < UIControl
    attr_accessor :text
    attr :tracking_view

    def initWithFrame(frame)
      super.tap do
        @exposed = true
        @pressed = false
        @tracking_view = XrayTypewriterView.alloc.initWithFrame([[0, 0], [self.frame.size.width, 0]])
      end
    end

    def exposed?
      @exposed
    end

    def exposed=(value)
      @exposed = !! value
    end

    def drawRect(rect)
      context = UIGraphicsGetCurrentContext()
      color_space = CGColorSpaceCreateDeviceRGB()
      if @pressed
      else
        cgcolors = [
          :white.uicolor.CGColor,
          :light_gray.uicolor.CGColor,
        ]
      end

      points = [0, 1]

      gradient = CGGradientCreateWithColors(color_space, cgcolors, points.to_pointer(:float))
      CGContextDrawLinearGradient(context, gradient, self.bounds.top_left, self.bounds.bottom_left, 0)

      text.drawAtPoint([17, 3], withFont: :bold.uifont(11))

      CGContextSaveGState(context)
      triangle_bounds = CGRect.new([0, 0], [20, 20]).shrink(6)
      :clear.uicolor.setStroke
      :light_gray.uicolor.setFill

      if false
        if @exposed
          CGContextMoveToPoint(context, triangle_bounds.top_right(true).x, triangle_bounds.top_right(true).y)
          CGContextAddLineToPoint(context, triangle_bounds.bottom_center(true).x, triangle_bounds.bottom_center(true).y)
          CGContextAddLineToPoint(context, triangle_bounds.top_left(true).x, triangle_bounds.top_left(true).y)
        else
          CGContextMoveToPoint(context, triangle_bounds.top_left(true).x, triangle_bounds.top_left(true).y)
          CGContextAddLineToPoint(context, triangle_bounds.center_right(true).x, triangle_bounds.center_right(true).y)
          CGContextAddLineToPoint(context, triangle_bounds.bottom_left(true).x, triangle_bounds.bottom_left(true).y)
        end
      end
      CGContextDrawPath(context, KCGPathFillStroke)
      CGContextRestoreGState(context)
    end

  end

end end
