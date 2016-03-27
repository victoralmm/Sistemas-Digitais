#include <stdio.h>
#include <stdlib.h>

typedef struct ponto{
	int x, y;
} ponto;

int area(ponto a, ponto b, ponto c){                                                /// Função verificação da area do triangulo.
	return abs((a.x*(b.y-c.y) + b.x*(c.y-a.y) + c.x*(a.y-b.y)));
}

int verificacao(ponto a, ponto b, ponto c, ponto p){                                /// Função verificação do ponto dentro do triangulo.
	int total = area(a,b,c);
	int A1 = area(a,c,p);
	int A2 = area(a,b,p);
	int A3 = area(c,p,b);

	if(A1+A2+A3 == total){
		return 1;
	}
	else{
		return 0;
	}
}

int main(){

	ponto pt1, pt2, pt3, p;

    printf("Ponto 1 do Triangulo - X e Y\n");              
	scanf("%d %d", &pt1.x, &pt1.y);
    printf("Ponto 2 do Triangulo - X e Y\n");
	scanf("%d %d", &pt2.x, &pt2.y);
    printf("Ponto 3 do Triangulo - X e Y\n");
	scanf("%d %d", &pt3.x, &pt3.y);
    printf("Ponto - X e Y\n");                                            
	scanf("%d %d", &p.x, &p.y);

	if(verificacao(pt1, pt2, pt3, p)){
		printf("\n\nDentro\n");
	}
	else{
		printf("\n\nFora\n");
	}

}
