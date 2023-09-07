class Snake
    attr_reader :body, :direction
  
    def initialize
      puts "Game initialized!"
      @body = [[10, 10], [10, 11], [10, 12]]
      @direction = 'up'
    end
  
    def move
      head = @body.first.dup
  
      case @direction
      when 'down'
        head[1] += 1
      when 'up'
        head[1] -= 1
      when 'left'
        head[0] -= 1
      when 'right'
        head[0] += 1
      end
  
      @body.unshift(head)
      @body.pop
    end
  
    def draw
      @body.each do |segment|
        draw_square(segment[0], segment[1], 'blue')
      end
    end
  
    def change_direction(new_direction)
      case new_direction
      when 'ArrowUp'
        @direction = 'up'
      when 'ArrowDown'
        @direction = 'down'
      when 'ArrowLeft'
        @direction = 'left'
      when 'ArrowRight'
        @direction = 'right'
      end
    end
  
    def grow
      tail = @body.last.dup
      case @direction
      when 'down'
        tail[1] -= 1
      when 'up'
        tail[1] += 1
      when 'left'
        tail[0] += 1
      when 'right'
        tail[0] -= 1
      end
      @body << tail
    end
  
    def collides_with_food?(food)
      head = @body.first
      food.position[0] == head[0] && food.position[1] == head[1]
    end
  
    def collides_with_self?
      head = @body.first
      @body[1..-1].any? { |segment| head[0] == segment[0] && head[1] == segment[1] }
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
  