class SnakeGame
    attr_reader :snake, :food, :game_over
  
    def initialize(width, height, grid_size)
      @width = width
      @height = height
      @grid_size = grid_size
      @snake = [[width / 2, height / 2]]
      @food = generate_food
      @game_over = false
      @direction = :right
    end
  
    def move(direction)
      return if @game_over
  
      case direction.to_sym
      when :up
        @direction = :up if @direction != :down
      when :down
        @direction = :down if @direction != :up
      when :left
        @direction = :left if @direction != :right
      when :right
        @direction = :right if @direction != :left
      end
  
      new_head = calculate_new_head
      if collision?(new_head)
        @game_over = true
        return
      end
  
      @snake.unshift(new_head)
      if new_head == @food
        @food = generate_food
      else
        @snake.pop
      end
    end
  
    private
  
    def generate_food
      food = nil
      loop do
        food = [rand(@width), rand(@height)]
        break unless @snake.include?(food)
      end
      food
    end
  
    def calculate_new_head
      head = @snake.first.dup
      case @direction
      when :up
        head[1] -= 1
      when :down
        head[1] += 1
      when :left
        head[0] -= 1
      when :right
        head[0] += 1
      end
      head.map { |coord| coord % @width }
    end
  
    def collision?(head)
      return true if @snake.include?(head)
      head[0].negative? || head[1].negative? || head[0] >= @width || head[1] >= @height
    end
  end
  