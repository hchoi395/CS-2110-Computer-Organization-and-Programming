#ifndef MAIN_H
#define MAIN_H

#include "gba.h"

typedef struct player {
    int row;
    int col;
    int left;
    int right;
    int top;
    int bot;
    int attempt;
} Player;

typedef struct enemy {
    int row;
    int col;
    int left;
    int right;
    int top;
    int bot;
} Enemy;

typedef struct friend {
    int row;
    int col;
    int left;
    int right;
    int top;
    int bot;
} Friend;

typedef struct barrier {
    int row;
    int col;
    int left;
    int right;
    int top;
    int bot;
} Barrier;

typedef enum gba_state {
  STARTSCREEN,
  PLAY,
  WIN,
  WIN2,
  LOSE,
  LOSE2
} Gba_state;

void makePlayer(void);
void makeEnemy(void);
void makeFriend(void);
void makeBarrier(void);
void startGame(Gba_state *state);
void checkFriendCollision(Gba_state *state);
void checkEnemyCollision(Gba_state *state, Enemy e);
int checkBarrierCollision(void);
void numberOfAttempts(void);
void increaseAttempts(void);
void clearAttempts(void);

#endif
