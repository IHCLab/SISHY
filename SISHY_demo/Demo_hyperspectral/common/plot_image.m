function plot_image(img_clean,img_noisy,img_SISHY)

band_set=[25 12 6];
normColor=@(R)max(min((R-mean(R(:)))/std(R(:)),2),-2)/3+0.5;

figure()
subplot(1,3,1)
temp_show=img_clean(:,:,band_set);
temp_show=normColor(temp_show);
imshow(temp_show);title({'Reference'});

subplot(1,3,2)
band_set=[25 15 6];
normColor=@(R)max(min((R-mean(R(:)))/std(R(:)),2),-2)/3+0.5;
temp_show=img_noisy(:,:,band_set);
temp_show=normColor(temp_show);
imshow(temp_show);title({'Incomplete Hyperspectral Image'});

subplot(1,3,3)
normColor=@(R)max(min((R-mean(R(:)))/std(R(:)),2),-2)/3+0.5;
temp_show=img_SISHY(:,:,band_set);
temp_show=normColor(temp_show);
imshow(temp_show);title('Recovered Image ');