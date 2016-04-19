# value-types

Experiment to compare value type vs reference types in Swift

Graphs are generated using Octave

```octave
step = 500
x = step:step:iterations*step
d = csvread('data.txt');
plot(x, d(1,:), x, d(2,:))
legend('Value', 'Reference')
grid on
xlabel('xxx')
ylabel('Time (seconds)')
print -djpg xx.jpg

```
