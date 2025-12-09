function skew_v=vecttoskew(v)
skew_v=[  0,      -v(3,1), v(2,1);
          v(3,1),  0,     -v(1,1);
         -v(2,1),  v(1,1), 0     ];
   