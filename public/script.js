document.addEventListener("DOMContentLoaded", function() {
  const canvas = document.getElementById("gameCanvas");
  const ctx = canvas.getContext("2d");

  let snakeGame;

  function drawSnake(snake) {
    ctx.fillStyle = "green";
    snake.forEach(segment => {
      ctx.fillRect(segment[0] * 20, segment[1] * 20, 20, 20);
    });
  }

  function drawFood(food) {
    ctx.fillStyle = "red";
    ctx.fillRect(food[0] * 20, food[1] * 20, 20, 20);
  }

  function clearCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
  }

  function move(direction) {
    fetch(`/api/move/${direction}`)
      .then(response => response.json())
      .then(data => {
        snakeGame = data;
        clearCanvas();
        drawSnake(snakeGame.snake);
        drawFood(snakeGame.food);
        if (snakeGame.game_over) {
          alert("Game Over!");
        }
      });
  }

  document.addEventListener("keydown", event => {
    switch (event.key) {
      case "ArrowUp":
        move("up");
        break;
      case "ArrowDown":
        move("down");
        break;
      case "ArrowLeft":
        move("left");
        break;
      case "ArrowRight":
        move("right");
        break;
    }
  });

  function init() {
    fetch('/api/move/init') // Add a new route in your Sinatra app to initialize the game state
      .then(response => response.json())
      .then(data => {
        snakeGame = data;
        drawSnake(snakeGame.snake);
        drawFood(snakeGame.food);
      });
  }

  init();
});
