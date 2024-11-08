import 'dart:core';

List details = [
  {
    'username': 'sri',
    'password': '123',
    'role': 'biller',
  },
  {
    'username': 'praveen',
    'password': '123',
    'role': 'manager',
  },
  {
    'username': 'parama',
    'password': '123',
    'role': 'admin',
  },
  {
    'username': '123',
    'password': '123',
    'role': 'inventry',
  },
];



List medicinemaster = [
  {
    'MedicineName': "Med1",
    'Brand': "brand1",
  },
  {
    'MedicineName': "Med2",
    'Brand': "brand2",
  },
  {
    'MedicineName': "Med3",
    'Brand': "brand3",
  },
  {
    'MedicineName': "Med4",
    'Brand': "brand4",
  },
  {
    'MedicineName': "Med5",
    'Brand': "brand5",
  },
  {
    'MedicineName': "Med6",
    'Brand': "brand6",
  },
  {
    'MedicineName': "Med7",
    'Brand': "brand7",
  },
  {
    'MedicineName': "Med8",
    'Brand': "brand8",
  },
  {
    'MedicineName': "Med9",
    'Brand': "brand9",
  },
  {
    'MedicineName': "Med10",
    'Brand': "brand10",
  },
];

List stock = [
  {
    'MedName': "Med1",
    'Quantity': 6,
    'UnitPrice': 12.0,
  },
  {
    'MedName': "Med2",
    'Quantity': 59,
    'UnitPrice': 5.0,
  },
  {
    'MedName': "Med3",
    'Quantity': 65,
    'UnitPrice': 7.0,
  },
  {
    'MedName': "Med4",
    'Quantity': 57,
    'UnitPrice': 15.0,
  },
  {
    'MedName': "Med5",
    'Quantity': 55,
    'UnitPrice': 13.0,
  },
  {
    'MedName': "Med6",
    'Quantity': 545,
    'UnitPrice': 6.0,
  },
  {
    'MedName': "Med7",
    'Quantity': 554,
    'UnitPrice': 5.5,
  },
  {
    'MedName': "Med8",
    'Quantity': 25,
    'UnitPrice': 6.0,
  },
  {
    'MedName': "Med9",
    'Quantity': 35,
    'UnitPrice': 8.0,
  },
  {
    'MedName': "Med10",
    'Quantity': 15,
    'UnitPrice': 55.0,
  },
];

List billmaster = [
  {
    'BillNo': 1,
    'BillDate': "2023-01-20",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 2,
    'BillDate': "2023-02-18",
    'BillAmount': 400.0,
    'BillGST': 64.0,
    'NetPrice': 464.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 3,
    'BillDate': "2023-03-17",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 4,
    'BillDate': "2023-05-06",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 5,
    'BillDate': "2023-03-19",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 6,
    'BillDate': "2023-03-16",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 7,
    'BillDate': "2023-05-26",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 8,
    'BillDate': "2023-04-16",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 9,
    'BillDate': "2023-01-12",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "vijay",
  },
  {
    'BillNo': 10,
    'BillDate': "2022-12-20",
    'BillAmount': 200.0,
    'BillGST': 36.0,
    'NetPrice': 236.0,
    'UserId': "ramesh",
  },
  // {
  //   'BillNo': 11,
  //   'BillDate': '2023-07-28',
  //   'BillAmount': 120.0,
  //   'BillGST': 18.0,
  //   'NetPrice': 138.0,
  //   'UserId': 'sri'
  // }
];

List billdetails = [
  {
    'BillNo': 1,
    'MedicineName': "Med1",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 2,
    'MedicineName': "Med2",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 3,
    'MedicineName': "Med 4",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 4,
    'MedicineName': "Med5",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 5,
    'MedicineName': "Med6",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 6,
    'MedicineName': "Med7",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 7,
    'MedicineName': "Med8",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 8,
    'MedicineName': "Med9",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 9,
    'MedicineName': "Med10",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
  {
    'BillNo': 10,
    'MedicineName': "Med3",
    'Quantity': 1,
    'UnitPrice': 200.0,
    'TotalAmount': 236.0,
  },
];

List loginhistory = [
  // {
  //   'username': 'sri',
  //   'login': '11/05/2002 22:33:77',
  //   'logout': '12/05/2002 21:34:67',
  // },
  // {
  //   'username': 'praveen',
  //   'login': '13/06/2001 29:44:57',
  //   'logout': '15/05/2003 55:64:47',
  // },
  // {
  //   'username': 'parama',
  //   'login': '06/06/1998 20:30:60',
  //   'logout': '15/05/2006  25:36:68',
  // },
  // {
  //   'username': 'vijay',
  //   'login': '17/05/2023 27:34:67',
  //   'logout': '12/09/2012 28:34:67',
  // },
];
