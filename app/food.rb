class Food
    attr_reader :position
  
    def initialize
      @position = [5, 5]
    end
  
    def spawn
      @position = [rand(40), rand(30)]
    end
  
    def draw
      draw_square(@position[0], @position[1], 'red')
    end
  
    private
  
    def draw_square(x, y, color)
      %x{
        var canvas = document.getElementById('gameCanvas');
        var ctx = canvas.getContext('2d');
        ctx.fillStyle = #{color};
        ctx.fillRect(#{x * 20}, #{y * 20}, 20, 20);
      }
    end
  end
  