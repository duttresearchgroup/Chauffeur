/****************************************************************************
** Meta object code from reading C++ file 'ControlButtonsPanel.hpp'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.9.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../../../../src/software/VO/AlternativeVO/ControlButtonsPanel.hpp"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ControlButtonsPanel.hpp' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.9.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_alternative_vo__ControlButtonsPanel_t {
    QByteArrayData data[10];
    char stringdata0[165];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_alternative_vo__ControlButtonsPanel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_alternative_vo__ControlButtonsPanel_t qt_meta_stringdata_alternative_vo__ControlButtonsPanel = {
    {
QT_MOC_LITERAL(0, 0, 35), // "alternative_vo::ControlButton..."
QT_MOC_LITERAL(1, 36, 14), // "hasClickedPlay"
QT_MOC_LITERAL(2, 51, 0), // ""
QT_MOC_LITERAL(3, 52, 14), // "hasClickedStop"
QT_MOC_LITERAL(4, 67, 17), // "hasClickedForward"
QT_MOC_LITERAL(5, 85, 15), // "hasClickedReset"
QT_MOC_LITERAL(6, 101, 14), // "onClickPlayBtn"
QT_MOC_LITERAL(7, 116, 14), // "onClickStopBtn"
QT_MOC_LITERAL(8, 131, 17), // "onClickForwardBtn"
QT_MOC_LITERAL(9, 149, 15) // "onClickResetBtn"

    },
    "alternative_vo::ControlButtonsPanel\0"
    "hasClickedPlay\0\0hasClickedStop\0"
    "hasClickedForward\0hasClickedReset\0"
    "onClickPlayBtn\0onClickStopBtn\0"
    "onClickForwardBtn\0onClickResetBtn"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_alternative_vo__ControlButtonsPanel[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,
       3,    0,   55,    2, 0x06 /* Public */,
       4,    0,   56,    2, 0x06 /* Public */,
       5,    0,   57,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    0,   58,    2, 0x0a /* Public */,
       7,    0,   59,    2, 0x0a /* Public */,
       8,    0,   60,    2, 0x0a /* Public */,
       9,    0,   61,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void alternative_vo::ControlButtonsPanel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        ControlButtonsPanel *_t = static_cast<ControlButtonsPanel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->hasClickedPlay(); break;
        case 1: _t->hasClickedStop(); break;
        case 2: _t->hasClickedForward(); break;
        case 3: _t->hasClickedReset(); break;
        case 4: _t->onClickPlayBtn(); break;
        case 5: _t->onClickStopBtn(); break;
        case 6: _t->onClickForwardBtn(); break;
        case 7: _t->onClickResetBtn(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            typedef void (ControlButtonsPanel::*_t)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ControlButtonsPanel::hasClickedPlay)) {
                *result = 0;
                return;
            }
        }
        {
            typedef void (ControlButtonsPanel::*_t)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ControlButtonsPanel::hasClickedStop)) {
                *result = 1;
                return;
            }
        }
        {
            typedef void (ControlButtonsPanel::*_t)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ControlButtonsPanel::hasClickedForward)) {
                *result = 2;
                return;
            }
        }
        {
            typedef void (ControlButtonsPanel::*_t)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ControlButtonsPanel::hasClickedReset)) {
                *result = 3;
                return;
            }
        }
    }
    Q_UNUSED(_a);
}

const QMetaObject alternative_vo::ControlButtonsPanel::staticMetaObject = {
    { &QWidget::staticMetaObject, qt_meta_stringdata_alternative_vo__ControlButtonsPanel.data,
      qt_meta_data_alternative_vo__ControlButtonsPanel,  qt_static_metacall, nullptr, nullptr}
};


const QMetaObject *alternative_vo::ControlButtonsPanel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *alternative_vo::ControlButtonsPanel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_alternative_vo__ControlButtonsPanel.stringdata0))
        return static_cast<void*>(this);
    return QWidget::qt_metacast(_clname);
}

int alternative_vo::ControlButtonsPanel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QWidget::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void alternative_vo::ControlButtonsPanel::hasClickedPlay()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void alternative_vo::ControlButtonsPanel::hasClickedStop()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void alternative_vo::ControlButtonsPanel::hasClickedForward()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void alternative_vo::ControlButtonsPanel::hasClickedReset()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
