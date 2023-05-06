#include <stdio.h>
#include <stdlib.h>
int outcome(int other, int you) {
    return (other + 1) % 3 == you ? 2 : other == you ? 1 : 0;
}
int main() {
    FILE *input = fopen("2022-02.txt", "r");
    char line[5];
    int totalPoints = 0;
    while (fgets(line, 5, input)) {
        int other = line[0] - 65;
        int you = line[2] - 88;
        int points = you + 1 + outcome(other, you) * 3;
        totalPoints += points;
    }
    printf("%d", totalPoints);
    return 0;
}
