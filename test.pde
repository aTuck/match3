class Test {
    Test () {
        background(0);
	    for (int i = 0; i<12; i++){
	    	rect(random(1024), random(768)-random(12), random(3), random(12));
	    }
    }
}