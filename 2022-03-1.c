#include <stdio.h>
#include <stdlib.h>
int getItemCount(char rucksack[50]) {
    for (int i = 0; i < 50; i++) {
        if (rucksack[i] == '\n') {
            return i;
        }
    }
}
int getPriority(char rucksack[50], int itemCount) {
    for (int i = 0; i < itemCount / 2; i++) {
        for (int j = 0; j < itemCount / 2; j++) {
            if (rucksack[i] == rucksack[j + itemCount / 2]) {
                int priority = rucksack[i];
                return priority >= 97 ? priority - 96 : priority - 64 + 26;
            }
        }
    }
}
int main() {
    FILE *input = fopen("2022-03.txt", "r");
    char line[50];
    int totalPriority = 0;
    while (fgets(line, 50, input)) {
        int itemCount = getItemCount(line);
        totalPriority += getPriority(line, itemCount);
    }
    printf("%d", totalPriority);
    return 0;
}
