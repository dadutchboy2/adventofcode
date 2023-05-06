#include <stdio.h>
#include <stdlib.h>
void max(int *a, int b) {
    *a = *a > b ? *a : b;
}
int main() {
    FILE *input;
    input = fopen("2022-01.txt", "r");
    char string[7];
    int sumAmount;
    int maxAmounts[3];
    int count = 0;
    while (fgets(string, 7, input)) {
        int amount = atoi(string);
        if (amount == 0) {
            int lowestMax = 0x7fffffff;
            int lowestMaxIndex;
            for (int i = 0; i < 3; i++) {
                int maxAmount = maxAmounts[i];
                if (lowestMax > maxAmount) {
                    lowestMax = maxAmount;
                    lowestMaxIndex = i;
                }
            }
            max(&maxAmounts[lowestMaxIndex], sumAmount);
            sumAmount = 0;
        }
        else {
            sumAmount += amount;
        }
        count++;
    }
    printf("%d", maxAmounts[0] + maxAmounts[1] + maxAmounts[2]);
    return 0;
}
