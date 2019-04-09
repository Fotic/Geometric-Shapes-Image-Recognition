%  Προετοιμασία δεδομένων για μάθηση

Num_Inputs=10;% αριθμός κριτηρίων
P=zeros(Num_Inputs,15);% πίνακας εισόδου
T=zeros(5,15); % αρχικοποίηση πίνακα με 0

for h=1:15 % 15 επαναλήψεις για 15 εικόνες
    switch h
       case 1
          Img = imread('t\t1.bmp'); %Τρίγωνο
          Target=[1;-1;-1;-1;-1] ;
       case 2 
          Img = imread('t\t2.bmp');
          Target=[1;-1;-1;-1;-1] ;
       case 3
           Img = imread('t\t3.bmp');
           Target=[1;-1;-1;-1;-1] ;
       case 4
           Img = imread('s\s1.bmp'); %Αστέρι
           Target=[-1;1;-1;-1;-1] ;
       case 5
           Img = imread('s\s2.bmp');
           Target=[-1;1;-1;-1;-1];
       case 6
           Img = imread('s\s3.bmp');
           Target=[-1;1;-1;-1;-1];
       case 7
           Img = imread('c\c1.bmp'); %Κύκλος
           Target=[-1;-1;1;-1;-1];
       case 8
           Img = imread('c\c2.bmp');
           Target=[-1;-1;1;-1;-1];
       case 9
           Img = imread('c\c3.bmp');
           Target=[-1;-1;1;-1;-1];
       case 10
           Img = imread('p\p1.bmp'); %Πυραμίδα
           Target=[-1;-1;-1;1;-1];
       case 11
           Img = imread('p\p2.bmp');
           Target=[-1;-1;-1;1;-1];
       case 12
           Img = imread('p\p3.bmp');
           Target=[-1;-1;-1;1;-1];
       case 13
           Img = imread('rh\rh1.bmp'); %Ρόμβος
           Target=[-1;-1;-1;-1;1];
       case 14
           Img = imread('rh\rh2.bmp');
           Target=[-1;-1;-1;-1;1];
       case 15
           Img = imread('rh\rh3.bmp');
           Target=[-1;-1;-1;-1;1];
    end % τέλος της επανάληψης
    
    T(:,h)=Target ; % γέμισμα πίνακα Τ
[Num_Row,Num_column] = size(Img) ;% Καθορισμός μεγέθους εικόνας 
% γέμισμα πινάκων εισόδου 
           for i=1:Num_Inputs
                     for j=(((Num_Row/Num_Inputs)*(i-1))+1) : ((Num_Row/Num_Inputs)*(i))
                          for k=1 : Num_column
                             if Img(j,k)==0
                             P(i,h)=P(i,h)+k ;
                             end
                           end
                     end
           end
end % τέλος επανάληψης
%τέλος προετοιμασίας δεδομένων για μάθηση


% προετοιμασία δεδομένων για προσομοίωση 
S=zeros(Num_Inputs,5);% πίνακας προσομοίωσης

for h=1:5 % 5 επαναλήψεις για 5 εικόνες προσομοίωσης
    switch h
       case 1
          Img = imread('t\t4.bmp');
          
       case 2
           Img = imread('s\s4.bmp');
           
        case 3
           Img = imread('c\c4.bmp');
           
        case 4
           Img = imread('p\p4.bmp');
           
        case 5
           Img = imread('rh\rh4.bmp');   
    end %τέλος επανάληψης 

[Num_Row,Num_column] = size(Img) ;
% αρχικοποίηση για τον πίνακα εισόδου
           for i=1:Num_Inputs
                     for j=(((Num_Row/Num_Inputs)*(i-1))+1) : ((Num_Row/Num_Inputs)*(i))
                          for k=1 : Num_column
                             if Img(j,k)==0
                             S(i,h)=S(i,h)+k ;
                             end
                           end
                     end
           end
end % τέλος επανάληψης
%τέλος προετοιμασίας δεδομένων προσομοίωσης


% Κανονικοποίηση πινάκων
A=[P,S] ;
maxi=max(max(A));
mini=min(min(A));
[a,b]=size(A);for i=1:a
    for j=1:b
        AN(i,j)=2*(A(i,j)/(maxi-mini))-1;
    end
end

P=AN(:,1:15); %P=AN(:,1:9);
S=AN(:,16:20); %S=AN(:,10:12) ;
%τέλος κανονικοποίησης


% βήμα δημιουργίας νευρωνικού δικτύου και μάθησης

Num_Neuron_Hidden=20 ;% αριθμός των νευρώνω στο κρυφό στρώμα
net = newff(P,T,Num_Neuron_Hidden,{},'traingd');
net=init(net); % αρχικοποίηση εκ νέου των βαρών και των πολώσεων
net.trainparam.epochs=5000;% μεγίστος αριθμός εποχών
net.trainparam.goal=0.0001; % σφάλμα ανοχής
net=train(net,P,T); % ξεκίνημα της μάθησης
% τέλος μάθησης

% προσομοίωση 
y = sim(net,S);
% τέλος προσομοίωσης