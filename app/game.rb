class SnakeGame
    attr_reader :snake, :food, :score
  
    def initialize
      @snake = Snake.new
      @food = Food.new
      @score = 0
    end
  
    def handle_key(key)
      @snake.change_direction(key)
    end
  
    def move
      @snake.move
    end
  
    def draw
      @snake.draw
      @food.draw
    end
  
    def check_collisions
      if @snake.collides_with_food?(@food)
        @snake.grow
        @food.spawn
        @score += 10
      elsif @snake.collides_with_self?
        reset_game
      end
    end
  
    def generate_food
      @food.draw
    end
  
    private
  
    def reset_game
      @snake = Snake.new
      @food.spawn
      @score = 0
    end
  end
  