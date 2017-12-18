# The Game of Life

Inspired by [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway's_Game_of_Life)

## Instructions

Write some code to build out the GOL based on the following Business Rules:

The universe of the Game of Life is an infinite *two-dimensional* grid of square cells, 
each of which is in one of two possible states, alive or dead. Every cell interacts with its eight 
neighbours, which are the cells that are horizontally, vertically, or diagonally adjacent. At each 
step in time, the following transitions occur:

* Any live cell with < 2 live neighbours dies, as if caused by under-population.
* Any live cell with 2 || 3 live neighbours lives on to the next generation.
* Any live cell with > 3 live neighbours dies, as if by over-population.
* Any dead cell with 3 live neighbours becomes a live cell, as if by reproduction.

The initial pattern constitutes the seed of the system. The first generation is created by applying 
the above rules simultaneously to every cell in the seed—births and deaths occur simultaneously, and 
the discrete moment at which this happens is sometimes called a tick (in other words, each generation 
is a pure function of the preceding one). The rules continue to be applied repeatedly to create 
further generations.

## Running the Tests

At the command line, this should work for you:

    rspec spec/board_spec.rb --example "Board runs random for fun"
