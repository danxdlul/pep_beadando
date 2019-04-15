#include <stdio.h>
#include <omp.h>
#include <stdarg.h>
#include <time.h>
#include <stopper.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
unsigned int sleep(unsigned int seconds);
int main(int argc, char *argv[]) {

	stopperOMP stop;
	startSOMP(&stop);
	int n = 100;
	int threadcount = 1;
	int max_val = 0;
	int found = 0;
	if(argc>2){
		threadcount=atoi(argv[1]);
		n = atoi(argv[2]);
	}
	else if(argc>1){
		threadcount = atoi(argv[1]);
	}
	printf("Program elinditva az alabbi parameterekkel:\nSzalak szama: %d\nGeneralando szamok: %d\n\n",threadcount,n);
	//int values[n];
	time_t t;
    srand((unsigned) time(&t));

    int* values= (int*) malloc(n * sizeof(int));
	for(int i=0;i<n;i++){
		values[i] = (rand() % 100000) +1;
	}
	//printf("created values\n is %d\n",n);
	#pragma omp parallel for num_threads(threadcount) reduction(max:max_val)
	for(int i = 0;i<n;i++){
		if(max_val < values[i]){
			max_val = values[i];
		}
	}
	printf("Max value: %d\n",max_val);
    //int primes[max_val];
    int* primes = (int*) malloc(max_val * sizeof(int));
	char isPrime[max_val+1];
	#pragma omp parallel for num_threads(threadcount)
  	for (int i = 0; i <= max_val; i++)
    isPrime[i] = 1;

	printf("Set primes done\n");
  	for (int i = 2; i*i <= max_val; i++){
		  if (isPrime[i]){
			  #pragma omp parallel for num_threads(threadcount)
   	 		  for (int j = i*i; j <= max_val; j += i){
					    isPrime[j] = 0;
				  }
		  }
		
	  }

	#pragma omp parallel for num_threads(threadcount) schedule(dynamic)
	for(int i = 2;i<max_val+1;i++){
		if(isPrime[i]){
			#pragma omp critical(pleasework)
			{
			primes[found] = i;
			found++;
			}
			//printf("found prime %d\n",primes[found]);
			
			
		    
			
		}
	}
  	printf("Found all primes\n");
	char append[14];
	char tenyezok[100];
	#pragma omp parallel for num_threads(threadcount) firstprivate(values,primes) private(append,tenyezok) schedule(dynamic)
	for(int numbers = 0;numbers<n;numbers++){
		int j = 0;
		
		sprintf(tenyezok,"\n%d tenyezoi: ",values[numbers]);
		if(values[numbers] == 1){
			strcat(tenyezok,"1");
			//printf("%d\n",values[numbers]);
		}
		while(values[numbers] > 1){
			if(values[numbers] % primes[j] == 0){
				values[numbers] = values[numbers] / primes[j];
				sprintf(append,"%d ",primes[j]);
				strcat(tenyezok,append);
				
			}
			else{
				j++;
			}
		}
		//printf(tenyezok);
	}
	printf("\nDone checking factors\n");

	stopSOMP(&stop);

	FILE *f = fopen("times.txt", "a");
	if (f == NULL)
	{
   	 printf("Error opening file!\n");
   	 exit(1);
	}
	tprintfOMP(&stop,"\n",f,n,threadcount);

	fclose(f);
}

