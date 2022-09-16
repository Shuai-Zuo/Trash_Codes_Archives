#include <iostream> 
using namespace std;

class Grapha {
private:
	int arcs[100][100];    //存储弧的权值  
	int vexnum;      //存储顶点数 
	int edge;              //存储边数或弧数 
	int lowcost[100];      //存储到某结点最小的权值  
	int closest[100];      //存储对应权值的结点编号 
	int dist[100];
	int prev[100];
public:
	void creatGraph()//构造图
	{
		int i, j;
		int m[100][100];
		cout << "顶点数：";
		cin >> vexnum;
		cout << "边数：";
		cin >> edge;
		for (i = 1; i <= vexnum; i++)
			for (j = 1; j <= vexnum; j++)
			{
				arcs[i][j] = INT_MAX;//给每条边给最大的整型初值    
				m[i][j] = 0;
			}
		for (i = 0; i < edge; i++)
		{
			int a, b, c;
			cout << "顶点1：";
			cin >> a;
			cout << "顶点2：";
			cin >> b;
			cout << "v" << a << ",v" << b << "的权值：";
			cin >> c;
			arcs[a][b] = c;
			arcs[b][a] = c;
			m[a][b] = m[b][a] = 1;
		}
		//cout << "该图的邻接矩阵为：" << endl;
		for (i = 1; i <= vexnum; i++)
			for (int j = 1; j <= vexnum; j++)
			{
				cout << m[i][j] << " ";
				if (j == vexnum)
					cout << endl;
			}
	}

	void Dijkstra()
	{
		int i, j;
		int v0;
		bool S[100];// 判断是否已存入该点到S集合中
		cout << "请输入源点：";
		cin >> v0;
		for (int i = 1; i <= vexnum; ++i)
		{
			dist[i] = arcs[v0][i];
			S[i] = false;// 初始都未用过该点
			if (dist[i] == INT_MAX)
				prev[i] = -1;
			else
				prev[i] = v0;
		}
		dist[v0] = 0;
		S[v0] = true;
		for (i = 2; i <= vexnum; i++)
		{
			int mindist = INT_MAX;
			int u = v0;// 找出当前未使用的点j的dist[j]最小值
			for (int j = 1; j <= vexnum; ++j)
				if ((!S[j]) && dist[j] < mindist)
				{
					u = j;// u保存当前邻接点中距离最小的点的号码 
					mindist = dist[j];
				}
			S[u] = true;
			for (j = 1; j <= vexnum; j++)
				if ((!S[j]) && arcs[u][j] < INT_MAX)
				{
					if (dist[u] + arcs[u][j] < dist[j])//在通过新加入的u点路径找到离v0点更短的路径  
					{
						dist[j] = dist[u] + arcs[u][j];//更新dist 
						prev[j] = u;//记录前驱顶点 
					}
				}
		}
		for (i = 1; i <= vexnum; i++) {
			if (i != v0) {
				if (dist[i] != INT_MAX)
					cout << "顶点v" << v0 << "到顶点v" << i << "的最短路径长度为" << dist[i] << endl;
				else
					cout << "顶点v" << v0 << "到顶点v" << i << "无最短路径" << endl;

			}
		}
	}


	void prim()              //构造最小生成树  
	{
		int i, j;
		int min;
		cout << "该图的最小生成树为：";
		for (i = 2; i <= vexnum; i++)
		{
			lowcost[i] = arcs[1][i];    //把与1邻接的结点的权值储存在lowcost[i]中   
			closest[i] = 1;             //并把编号储存在closest[i]中  
		}
		lowcost[1] = 0;     //从1号结点开始访问   
		cout << "v" << 1 << " ";
		for (i = 2; i <= vexnum; i++)
		{
			min = INT_MAX;
			int k = 0;
			for (j = 2; j <= vexnum; j++)
				if ((lowcost[j] < min) && (lowcost[j] != 0))      //找到最小权值的那个邻接的结点   
				{
					min = lowcost[j];
					k = j;             //把它的编号赋给k；    
				}
			cout << "v" << k << " ";      //输出最小生成树    
			lowcost[k] = 0;     //设为0表示已访问    
			for (j = 2; j <= vexnum; j++)
				if (arcs[k][j] < lowcost[j])             //如果它到某结点的权值更小     
				{
					lowcost[j] = arcs[k][j];             //就把它的权值重新写入lowcost[j]中     
					closest[j] = k;                      //并修改结点的编号     
				}
		}
		cout << endl;
	}
};


int main()
{
	Grapha a;
	a.creatGraph();
	a.prim();
	a.Dijkstra();
	return 0;
}

