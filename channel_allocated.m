%% function to assign channel to requesting SU
function [tch,ch] = channel_allocated(query_x,query_y)
load chan_assignment.mat;
load tchan_assignment.mat;
tch=tchangrid(query_x,query_y);
ch=changrid(query_x,query_y);

% load 'PU_loc.mat';
% load 'tfigloc.mat';
% load 'boundaries.mat'
% filename = 'chan_assignment.mat';
% tfilename = 'tchan_assignment.mat';
% matObj = matfile(filename,'Writable',true);
% tmatObj = matfile(tfilename,'Writable',true);
% ch_alloc=matObj.changrid;
% tch_alloc=tmatObj.tchangrid;
% channels=[0 1 2];
% %r_0=30;
% %r_1=110;
% d = grid_res * sqrt((PUx - query_x)^2 + (PUy - query_y)^2);
% 
% found_2=0;
% found_3=0;
% 
% if(d> r_0 && d<=r_1 && query_x > 2 && query_y > 2 && query_x <Xgrids-1 && query_y<Ygrids-1)
%     for k=query_x -1 : query_x+1
%         for l=query_y-1:query_y+1
%             if(ch_alloc(k,l)==channels(3) && k~= query_x && l~=query_y )
%                 found_3=1;
%             elseif(ch_alloc(k,l)==channels(2) && k~= query_x && l~=query_y)
%                 found_2=1;
%             end
%         end
%     end
%     if(found_3==1 && found_2==1)
%         ch_alloc(query_x,query_y)=channels(1);
%     elseif(found_3 == 1 && found_2==0)
%         ch_alloc(query_x,query_y)=channels(2);
%     elseif(found_2==1 && found_3==0)
%         ch_alloc(query_x,query_y)=channels(3);
%     else
%         ch_alloc(query_x,query_y)=channels(3);
%     end
% end
% 
% %% for transfigured regions
% if(~inpolygon(query_x,query_y,x',y') && inpolygon(query_x,query_y,X',Y') ... 
%         && query_x > 2 && query_y > 2 && query_x <Xgrids-1 && query_y<Ygrids-1)
%     for k=query_x -1 : query_x+1
%         for l=query_y-1:query_y+1
%             if(tch_alloc(k,l)==channels(3) && k~= query_x && l~=query_y)
%                 found_3=1;
%             elseif(tch_alloc(k,l)==channels(2) && k~= query_x && l~=query_y)
%                 found_2=1;
%             end
%         end
%     end
%     if(found_3==1 && found_2==1)
%         tch_alloc(query_x,query_y)=channels(1);
%     elseif(found_3 == 1 && found_2==0)
%         tch_alloc(query_x,query_y)=channels(2);
%     elseif(found_2==1 && found_3==0)
%         tch_alloc(query_x,query_y)=channels(3);
%     else
%         tch_alloc(query_x,query_y)=channels(3);
%     end
% end
% 
% 
% 
% 
% fclose all;
% %changrid=ch_alloc;
% matObj.changrid=ch_alloc;
% tmatObj.changrid=tch_alloc;
% %save('chan_assignment.mat','changrid');
% ch=ch_alloc(query_x,query_y);
% tch=tch_alloc(query_x,query_y);
end