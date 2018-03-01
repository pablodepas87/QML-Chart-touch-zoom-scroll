#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);                             // va usata se vogliamo utillizare i grafici e le traduzioni(da verificare)

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main4.qml")));

    return app.exec();
}
