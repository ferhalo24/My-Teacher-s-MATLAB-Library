load release
splash = SplashScreen( 'Splashscreen', '3d_mec_title2_litle2.png');
      %splash.addText( 30, 50, 'My Cool App', 'FontSize', 30, 'Color', [0 0 0.6] )
      splash.addText( 280, 30, release, 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
      splash.addText( 300, 270, 'Loading...', 'FontSize', 20, 'Color', 'white' );
my_timer = timer('StartDelay',3,'TimerFcn',{@my_callback_fcn, splash});
start(my_timer);