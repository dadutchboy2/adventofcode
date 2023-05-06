#include <stdio.h>
#include <stdlib.h>
int getItemCount(char rucksack[50]) {
    for (int i = 0; i < 50; i++) {
        if (rucksack[i] == '\n') {
            return i;
        }
    }
}
void setString(char string1[50], char string2[50]) {
    for (int i = 0; i < 50; i++) {
        string1[i] = string2[i];
    }
}
void match(char matches[50], char matchees[50]) {
    char newMatches[50];
    int newMatchesCount = 0;
    for (int i = 0; i < getItemCount(matches); i++) {
        char item = matches[i];
        for (int j = 0; j < getItemCount(matchees); j++) {
            if (item == matchees[j]) {
                newMatches[newMatchesCount] = item;
                newMatchesCount++;
                break;
            }
        }
    }
    setString(matches, newMatches);
}
int main() {
    FILE *input = fopen("2022-03.txt", "r");
    char lines[3][50];
    int totalPriority = 0;
    while (1) {
        int stop = 0;
        for (int i = 0; i < 3; i++) {
            stop = !fgets(lines[i], 50, input);
        }
        if (stop) {break;}
        for (int i = 1; i < 3; i++) {
            match(lines[0], lines[i]);
        }
        int priority = lines[0][0];
        totalPriority += priority >= 97 ? priority - 96 : priority - 64 + 26;
    }
    printf("%d", totalPriority);
    return 0;
}
