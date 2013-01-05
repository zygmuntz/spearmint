results = csvread( 'results2.csv' );

err = results(:,1);

red = err < 0.085;
green = err < 0.09;
blue = err < 0.10;

plot( results( blue, 3 ), results( blue, 1 ), 'bo' )
hold on;

plot( results( green, 3 ), results( green, 1 ), 'go' )
plot( results( red, 3 ), results( red, 1 ), 'ro' )

xlabel( 'mtry')
ylabel( 'error' )

hold off;

