#include "QHello.hpp"

#include <QtWidgets/QBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextEdit>

namespace cframe {

QHello::QHello( QString const & toWhom, QWidget * parent )
: QWidget(parent)
, mLineEdit( new QLineEdit(toWhom, this) )
, mTextEdit( new QTextEdit(this) )
{
  auto vbl = new QVBoxLayout( this );
  this->setLayout( vbl );

  auto pb = new QPushButton( tr("Say it"), this );
  vbl->addWidget( pb );

  auto hbl = new QHBoxLayout;
  hbl->addWidget( new QLabel(tr("To whom:"), this) );
  hbl->addWidget( mLineEdit );

  vbl->addLayout( hbl );
  vbl->addWidget( mTextEdit );
  mTextEdit->setDisabled(true);

  connect( pb, &QPushButton::clicked, this, &QHello::sayIt );
  connect( mLineEdit, &QLineEdit::textEdited, this, &QHello::setToWhom );
}

QString QHello::toWhom() const
{
  return mLineEdit->text();
}

void QHello::setToWhom( QString const & whom )
{
  if ( toWhom() != whom ) {
    mLineEdit->setText( whom );
    toWhomChanged( whom );
  }
}

void QHello::sayIt()
{
  mTextEdit->clear();
  mTextEdit->setText( tr("Hello") + ' ' + toWhom() + "!!" );
  said();
}

} // namespace cframe