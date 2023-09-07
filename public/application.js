// Import Opal runtime
import 'opal';

// Import Ruby files
import SnakeGame from './app/game';
import Snake from './app/snake';
import Food from './app/food';

// Initialize game
document.addEventListener('DOMContentLoaded', () => {
  const game = new SnakeGame();
  game.start();
});

document.getElementById('gameCanvas').addEventListener('keydown', (event) => {
  game.handle_key(event.key);
});

document.getElementById('gameCanvas').focus();

setInterval(() => {
  game.move();
  game.draw();
  game.check_collisions();
  game.generate_food();
}, 100);
