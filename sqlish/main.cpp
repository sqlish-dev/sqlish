#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtConcurrent>

bool lowerCase(const QString & val)
{
	qDebug() << QThread::currentThreadId() << "val:" << val;

	bool ret = true;
	for(int i = 0; i < val.length(); ++i)
	{
		if(not val[i].isLower())
		{
			ret = false;
			break;
		}
	}
	qDebug() << QThread::currentThreadId() << "out";

	return ret;
}

int main(int argc, char *argv[])
{
	QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QApplication::setApplicationName("Sqlish");
	QApplication::setApplicationVersion("v1.0");
	QApplication app(argc, argv);

	QQmlApplicationEngine engine;
	engine.load(QUrl(QLatin1String("qrc:/main.qml")));
	if (engine.rootObjects().isEmpty())
		return -1;

//	QStringList strings;
//	strings << "AAA" << "BBB" << "sl;lkajds;fkljadf" << "DD" << "ee" << "ff" << "RR" << "sdfasdf" << "a;soiefj;n:Lkj:KLJ" << "KHKLJLHJHL" << "KLUHJKL";
//	QStringList result = QtConcurrent::blockingFiltered(strings, lowerCase);
//	qDebug() << result;

	return app.exec();
}
