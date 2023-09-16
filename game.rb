class SnakeGame
    attr_reader :grid_size, :grid_width, :grid_height, :snake, :food, :game_over
  
    def initialize(grid_size, grid_width, grid_height)
      @grid_size = grid_size
      @grid_width = grid_width
      @grid_height = grid_height
      @snake = [[2, 2]]  # Initial position of the snake
      @direction = [1, 0]  # Initial direction (right)
      @food = generate_food
      @game_over = false
    end
  
    def move(direction)
      case direction
      when 'up'
        @direction = [0, -1] unless @direction == [0, 1]  # Avoid moving into itself
      when 'down'
        @direction = [0, 1] unless @direction == [0, -1]
      when 'left'
        @direction = [-1, 0] unless @direction == [1, 0]
      when 'right'
        @direction = [1, 0] unless @direction == [-1, 0]
      end
  
      new_head = [@snake.first[0] + @direction[0], @snake.first[1] + @direction[1]]
  
      if collision?(new_head)
        @game_over = true
      else
        @snake.unshift(new_head)
        if new_head == @food
          @food = generate_food
        else
          @snake.pop
        end
      end
    end
  
    private
  
    def generate_food
      food = [rand(@grid_width), rand(@grid_height)]
      food = [rand(@grid_width), rand(@grid_height)] while @snake.include?(food)
      food
    end
  
    def collision?(head)
      head[0] < 0 || head[0] >= @grid_width || head[1] < 0 || head[1] >= @grid_height || @snake.include?(head)
    end
  end
  