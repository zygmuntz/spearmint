% histogram of good results vs the number of trees

results1 = csvread( 'results1.csv' );
err = results1(:,1);
green = err < 0.09;

hist( results1( green, 2 ), 30 );
xlabel( 'number of trees')
ylabel( 'good results count' )

h = findobj(gca,'Type','patch');
set(h,'FaceColor','g','EdgeColor','k');

figure( 2 );

results2 = csvread( 'results2.csv' );
err = results2(:,1);
green = err < 0.09;

hist( results2( green, 2 ), 30 );
xlabel( 'number of trees')
ylabel( 'good results count' )

h = findobj( gca, 'Type', 'patch' );
set( h, 'FaceColor', 'g', 'EdgeColor', 'k' );