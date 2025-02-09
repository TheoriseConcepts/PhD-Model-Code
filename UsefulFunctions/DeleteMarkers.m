cmb=combnk(1:10,2);
for k=1:45
hold on
subplot(10,10,(cmb(k,1)-1)*10+cmb(k,2))
delete(findobj(gca, 'Marker', '^'));
delete(findobj(gca, 'Marker', '.'));

hold on
subplot(10,10,(cmb(k,2)-1)*10+cmb(k,1))
delete(findobj(gca, 'Marker', '^'));
delete(findobj(gca, 'Marker', '.'));
end
