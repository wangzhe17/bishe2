function B = boundaries(BW, conn, dir)


if nargin < 3
   dir = 'cw';
end

if nargin < 2
   conn = 8;
end

L = bwlabel(BW, conn);


numObjects = max(L(:));
if numObjects > 0
   B = {zeros(0, 2)};
   B = repmat(B, numObjects, 1);
else
   B = {};
end


Lp = padarray(L, [1 1], 0, 'both');


M = size(Lp, 1);
if conn == 8
   offsets = [-1, M - 1, M, M + 1, 1, -M + 1, -M, -M-1];
else
   offsets = [-1, M, 1, -M];
end


if conn == 8
   next_search_direction_lut = [8 8 2 2 4 4 6 6];
else
   next_search_direction_lut = [4 1 2 3];
end


if conn == 8
   next_direction_lut = [2 3 4 5 6 7 8 1];
else
   next_direction_lut = [2 3 4 1];
end


START    = -1;
BOUNDARY = -2;


scratch = zeros(100, 1);


[rr, cc] = find((Lp(2:end-1, :) > 0) & (Lp(1:end-2, :) == 0));
rr = rr + 1;

for k = 1:length(rr)
   r = rr(k);
   c = cc(k);
   if (Lp(r,c) > 0) & (Lp(r - 1, c) == 0) & isempty(B{Lp(r, c)})

      idx = (c-1)*size(Lp, 1) + r;
      which = Lp(idx);
      
      scratch(1) = idx;
      Lp(idx) = START;
      numPixels = 1;
      currentPixel = idx;
      initial_departure_direction = [];
      
      done = 0;
      next_search_direction = 2;
      while ~done

         direction = next_search_direction;
         found_next_pixel = 0;
         for k = 1:length(offsets)
            neighbor = currentPixel + offsets(direction);
            if Lp(neighbor) ~= 0

               
               if (Lp(currentPixel) == START) & ...
                      isempty(initial_departure_direction)

                  initial_departure_direction = direction;
                  
               elseif (Lp(currentPixel) == START) & ...
                      (initial_departure_direction == direction)

                  done = 1;
                  found_next_pixel = 1;
                  break;
               end
               
               next_search_direction = ...
                   next_search_direction_lut(direction);
               found_next_pixel = 1;
               numPixels = numPixels + 1;
               if numPixels > size(scratch, 1)

                  scratch(2*size(scratch, 1)) = 0;
               end
               scratch(numPixels) = neighbor;
               
               if Lp(neighbor) ~= START
                  Lp(neighbor) = BOUNDARY;
               end
               
               currentPixel = neighbor;
               break;
            end
            
            direction = next_direction_lut(direction);
         end
         
         if ~found_next_pixel

            numPixels = 2;
            scratch(2) = scratch(1);
            done = 1;
         end
      end
      

      [row, col] = ind2sub(size(Lp), scratch(1:numPixels));
      B{which} = [row - 1, col - 1];
   end
end

if strcmp(dir, 'ccw')
   for k = 1:length(B)
      B{k} = B{k}(end:-1:1, :);
   end
end
