#pragma once

#include <CFrameDemo/API.h>

#include <QtWidgets/QWidget>

class QLineEdit;
class QTextEdit;

namespace cframe {

class CFRAMEDEMO_API QHello : public QWidget
{
  Q_OBJECT
  Q_PROPERTY( QString toWhom READ toWhom WRITE setToWhom NOTIFY toWhomChanged )
public:

  QHello( QString const & toWhom = "World", QWidget * parent = nullptr );
  virtual ~QHello() = default;

  QString toWhom() const;

public Q_SLOTS:

  void setToWhom( QString const & whom );
  void sayIt();

Q_SIGNALS:

  void toWhomChanged( QString const & toWhom );
  void said();

private:

  QLineEdit * mLineEdit;
  QTextEdit * mTextEdit;

}; // class QHello

} // namespace cframe
