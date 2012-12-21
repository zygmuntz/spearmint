args = argv();

for i = 1:nargin
	args{i} = str2num( args{i} );
end

args

a4_init
#a4_main( 300, args{1}, args{2}, args{3}, args{4} )
a4_main( 300, 0.02, args{1}, 1000 )