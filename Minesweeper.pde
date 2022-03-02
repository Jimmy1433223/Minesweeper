import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList < MSButton > bombs; //ArrayList of just the minesweeper buttons that are mined
public boolean game = true;
public int somePressed = 0;
public void setup() {
    size(400, 400);
    textAlign(CENTER, CENTER);

    // make the manager
    Interactive.make(this);

    //declare and initialize buttons
    bombs = new ArrayList < MSButton > ();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int row = 0; row < NUM_ROWS; row++) {
        for (int col = 0; col < NUM_COLS; col++) {
            buttons[row][col] = new MSButton(row, col);
        }
    }

    setBombs();
}
public void setBombs() {

    int num_bombs = 0;
    while (num_bombs < 50) {
        //randomly picks where the bomb will be 
        int row = (int)(Math.random() * 20);
        int col = (int)(Math.random() * 20);
        if (bombs.contains(buttons[row][col]) == false) {
            num_bombs++;
            bombs.add(buttons[row][col]);
        }
    }
}

public void draw() {
    //background( 0 );
    if (isWon())
        displayWinningMessage();
    if (game == false)
        displayLosingMessage();
}
public boolean isWon() {

    /*if(isValid(row,col)&&bombs.contains(buttons[row][col])){
        return true; 
    }*/
    if (somePressed == 390) {
        return true;
    }
    return false;
}
public void displayLosingMessage() {
    String word = "You Lose";
    for (int i = 0; i < word.length(); i++) {
        buttons[NUM_ROWS / 2][i + 5].setLabel(word.substring(i, i + 1));

    }



}
public void displayWinningMessage() {
    for (int i = 10; i < 13; i++) {
        String word = "WIN";
        buttons[i][8].setLabel(word.substring(i - 10, i - 9));

    }

}

public class MSButton {
    private int r, c;
    private float x, y, width, height;
    private boolean clicked, marked;
    private String label;

    public MSButton(int rr, int cc) {
        width = 400 / NUM_COLS;
        height = 400 / NUM_ROWS;
        r = rr;
        c = cc;
        x = c * width;
        y = r * height;
        label = "";
        marked = clicked = false;
        Interactive.add(this); // register it with the manager
    }
    public boolean isMarked() {
        return marked;
    }
    public boolean isClicked() {
        return clicked;
    }
    // called by manager
    public void mousePressed() {
        clicked = true;
        somePressed++;
        //System.out.println(somePressed);
        //your code here
        if (keyPressed == true) {
            //toggles marked and not marked
            marked = !marked;

        } else if (bombs.contains(this)) {
            game = false;

        } else if (countBombs(r, c) > 0) {
            label = "" + countBombs(r, c);
        } else {
            if (isValid(r - 1, c - 1) && buttons[r - 1][c - 1].clicked == false) {
                buttons[r - 1][c - 1].mousePressed();
            }
            if (isValid(r - 1, c) && buttons[r - 1][c].clicked == false) {
                buttons[r - 1][c].mousePressed();
            }
            if (isValid(r - 1, c + 1) && buttons[r - 1][c + 1].clicked == false) {
                buttons[r - 1][c + 1].mousePressed();

            }
            if (isValid(r, c - 1) && buttons[r][c - 1].clicked == false) {
                buttons[r][c - 1].mousePressed();
            }
            if (isValid(r, c + 1) && buttons[r][c + 1].clicked == false) {
                buttons[r][c + 1].mousePressed();
            }
            if (isValid(r + 1, c - 1) && buttons[r + 1][c - 1].clicked == false) {
                buttons[r + 1][c - 1].mousePressed();
            }
            if (isValid(r + 1, c) && buttons[r + 1][c].clicked == false) {
                buttons[r + 1][c].mousePressed();
            }
            if (isValid(r + 1, c + 1) && buttons[r + 1][c + 1].clicked == false) {
                buttons[r + 1][c + 1].mousePressed();
            }
            //marked = true;
        }
    }

    public void draw() {
        if (marked) {
            fill(0);
            //somePressed++;
        } else if (clicked && bombs.contains(this)) {
            fill(255, 0, 0);
            game = false;


        } else if (bombs.contains(this) && (game == false)) {
            fill(255, 0, 0);
        } else if (clicked) {
            fill(255, 255, 255);

        } else
            fill(255, 197, 0);

        rect(x, y, width, height);
        fill(0);
        text(label, x + width / 2, y + height / 2);


    }
    public void setLabel(String newLabel) {
        label = newLabel;
    }
    public boolean isValid(int r, int c) {
        //your code here
        if (r < 0) {
            return false;
        }
        if (r >= 20) {
            return false;
        }
        if (c < 0) {
            return false;
        }
        if (c >= 20) {
            return false;
        }
        return true;
    }
    public int countBombs(int row, int col) {
        int numBombs = 0;
        //your code here
        if (isValid(row - 1, col - 1) && bombs.contains(buttons[row - 1][col - 1])) {
            numBombs++;
        }
        if (isValid(row - 1, col) && bombs.contains(buttons[row - 1][col])) {
            numBombs++;
        }
        if (isValid(row - 1, col + 1) && bombs.contains(buttons[row - 1][col + 1])) {
            numBombs++;
        }
        if (isValid(row, col - 1) && bombs.contains(buttons[row][col - 1])) {
            numBombs++;
        }
        if (isValid(row, col + 1) && bombs.contains(buttons[row][col + 1])) {
            numBombs++;
        }
        if (isValid(row + 1, col - 1) && bombs.contains(buttons[row + 1][col - 1])) {
            numBombs++;
        }
        if (isValid(row + 1, col) && bombs.contains(buttons[row + 1][col])) {
            numBombs++;
        }
        if (isValid(row + 1, col + 1) && bombs.contains(buttons[row + 1][col + 1])) {
            numBombs++;
        }
        return numBombs;
    }
}
