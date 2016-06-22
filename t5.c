#include<stdio.h>
#include<stdlib.h>

typedef struct{
    int x,
        y;
}PNT;

int verificar(PNT pnt[4]);

int dtrm(PNT ponto1, PNT ponto2, PNT ponto3);

int main(){
    int ver;
    PNT p[4];

    FILE *pontos;
    FILE *result;

    pontos = fopen("entradas.txt", "r");
    result = fopen("saidas_C.txt", "w");

    if (pontos == NULL){
        printf("\nErro na leitura do arquivo!\n");
        exit(1);
    }
    if (result == NULL){
        printf("\nErro na escrita do arquivo!\n");
        exit(1);
    }

    while (fscanf(pontos, "%d %d %d %d %d %d %d %d", &p[0].x, &p[0].y ,&p[1].x, &p[1].y, &p[2].x, &p[2].y, &p[3].x, &p[3].y) != EOF){
       ver = verificar(p);
       fprintf(result, "%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t= %d\n", p[0].x, p[0].y ,p[1].x, p[1].y, p[2].x, p[2].y, p[3].x, p[3].y, ver);
    }

    free(result);
    free(pontos);

    return 0;
}


int verificar(PNT pnt[4]){
    int ver, det, detA, detB, detC;

    det = dtrm(pnt[1], pnt[2], pnt[3]);

    detA = dtrm(pnt[0], pnt[1], pnt[2])<0;
    detB = dtrm(pnt[0], pnt[2], pnt[3])<0;
    detC = dtrm(pnt[0], pnt[3], pnt[1])<0;

    return detA == detB && detB == detC;
}

int dtrm(PNT ponto1, PNT ponto2, PNT ponto3){
    int deter;
	
	deter = ((ponto1.x - ponto3.x) * (ponto2.y - ponto3.y) - (ponto2.x - ponto3.x) * (ponto1.y - ponto3.y));
	
    return deter;
}