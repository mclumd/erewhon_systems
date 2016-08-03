named(fif(bird(X), conslusion(fly(X))), birdsfly).
named(fif(penguin(X), conclusion(not(fly(X)))), penguinsdontfly).
if(penguin(X), bird(X)).
prefer(penguinsdontfly, birdsfly).
