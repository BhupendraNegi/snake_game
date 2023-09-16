let snakeGame;
const gridSize = 20;

function setup() {
  createCanvas(400, 400);
  frameRate(10);
  snakeGame = new SnakeGame();
}

function draw() {
  background(220);
  snakeGame.move();
  snakeGame.display();
}

function keyPressed() {
  switch (keyCode) {
    case UP_ARROW:
      snakeGame.changeDirection(0, -1);
      break;
    case DOWN_ARROW:
      snakeGame.changeDirection(0, 1);
      break;
    case LEFT_ARROW:
      snakeGame.changeDirection(-1, 0);
      break;
    case RIGHT_ARROW:
      snakeGame.changeDirection(1, 0);
      break;
  }
}

class SnakeGame {
  constructor() {
    this.snake = [[2, 2]];  // Initial position of the snake
    this.direction = [1, 0];  // Initial direction (right)
    this.food = this.generateFood();
    this.gameOver = false;
  }

  move() {
    if (this.gameOver) return;

    let newHead = [this.snake[0][0] + this.direction[0], this.snake[0][1] + this.direction[1]];

    if (this.collision(newHead)) {
      this.gameOver = true;
    } else {
      this.snake.unshift(newHead);
      if (this.food[0] === newHead[0] && this.food[1] === newHead[1]) {
        this.food = this.generateFood();
      } else {
        this.snake.pop();
      }
    }
  }

  changeDirection(x, y) {
    if (this.direction[0] !== -x || this.direction[1] !== -y) {
      this.direction = [x, y];
    }
  }

  generateFood() {
    let food;
    do {
      food = [floor(random(width / gridSize)), floor(random(height / gridSize))];
    } while (this.snake.some(segment => segment[0] === food[0] && segment[1] === food[1]));
    return food;
  }

  collision(head) {
    return (
      head[0] < 0 || head[0] >= width / gridSize ||
      head[1] < 0 || head[1] >= height / gridSize ||
      this.snake.some(segment => segment[0] === head[0] && segment[1] === head[1])
    );
  }

  display() {
    noStroke();
    fill(0);
    this.snake.forEach(segment => rect(segment[0] * gridSize, segment[1] * gridSize, gridSize, gridSize));

    fill(255, 0, 0);
    rect(this.food[0] * gridSize, this.food[1] * gridSize, gridSize, gridSize);

    if (this.gameOver) {
      fill(255, 0, 0);
      textSize(32);
      textAlign(CENTER, CENTER);
      text('Game Over', width / 2, height / 2);
    }
  }
}
