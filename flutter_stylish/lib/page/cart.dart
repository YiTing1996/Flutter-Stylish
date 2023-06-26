import 'package:flutter_stylish/helper/export/common_export.dart';
import 'package:flutter_stylish/tappay_handler.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar,
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(
                child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(Colors.grey)));
          } else if (state is CartErrorState) {
            return const Center(
                child: Text('Something went wrong. Try again later!',
                    style: titleTextStyle));
          } else if (state is CartLoadedState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  verticalSpace,
                  const Text('購物車商品', style: titleTextStyle),
                  ItemWidget(
                    items: state.cart.cartItems,
                    onDelete: (index) {
                      context
                          .read<CartBloc>()
                          .add(CartRemoveEvent(state.cart.cartItems[index]));
                    },
                  ),
                  const AccountWidget(),
                  const PaymentWidget(),
                  extraVerticalSpace,
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          debugPrint('點擊結帳');
                          if (state is CheckoutLoadedState) {
                            debugPrint('取得結帳資訊 ${state.checkout}');
                            Tappay.getPrime(
                              cardNumber: state.cardNumber!,
                              dueMonth: state.dueMonth!,
                              dueYear: state.dueYear!,
                              ccv: state.ccv!,
                              onSuccess: (prime) {
                                showOkDialog(context, 'Payment Success', prime);
                              },
                              onFail: (msg) {
                                showOkDialog(context, 'Payment Fail', msg);
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 50),
                            backgroundColor: Colors.black45,
                            textStyle: secTitleTextStyle),
                        child: const Text(
                          '確認結帳',
                          style: secTitleTextStyle,
                        ),
                      );
                    },
                  )
                ],
              )),
            );
          }
          return Container(); // 都沒有接收到的狀態
        },
      ),
    );
  }
}

class ItemWidget extends StatefulWidget {
  final List<CartItem> items;
  final void Function(int index) onDelete;
  const ItemWidget({Key? key, required this.items, required this.onDelete})
      : super(key: key);
  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widget.items.length * 100 + 25,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Image.network(
                      widget.items[index].mainImage,
                      width: screenWidth < 650 ? 60 : 80,
                      height: screenWidth < 650 ? 80 : 100,
                      fit: BoxFit.fill,
                    ),
                    horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.items[index].title),
                        Text(widget.items[index].size),
                        Text(widget.items[index].color.name),
                      ],
                    ),
                    Expanded(
                      // 放置在Expanded內才可以靠右對齊
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            NumChangeWidget(
                                num: widget.items[index].count,
                                width: screenWidth * 1 / 10,
                                onValueChanged: (selected) {
                                  debugPrint('Change to $selected');
                                }),
                            GestureDetector(
                              onTap: () {
                                widget.onDelete(index);
                              },
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 26,
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  DeliverTime _deliverTime = DeliverTime.all;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    Row createInputRow(String title, Function(String text) onChanged) {
      return Row(children: [
        SizedBox(
          width: 80,
          child: Text(title, style: subtitleTextStyle),
        ),
        horizontalSpace,
        SizedBox(
          // TextField包在Row裡面需要給固定的大小
          width: screenWidth - 150,
          child: TextFormField(
              onChanged: (value) {
                onChanged(value);
              },
              keyboardType: TextInputType.number,
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Cant bet empty'
                    : null;
              }),
        ),
      ]);
    }

    Row createRadioRow(DeliverTime current) {
      return Row(children: [
        Radio<DeliverTime>(
          materialTapTargetSize:
              MaterialTapTargetSize.shrinkWrap, // 縮減Radio的Padding
          value: current,
          groupValue: _deliverTime,
          onChanged: (DeliverTime? value) {
            setState(() {
              _deliverTime = value!;
            });
          },
        ),
        Text(current.rawValue(), style: contentTextStyle),
      ]);
    }

    return BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
      if (state is CheckoutLoadedState) {
        return ExpansionTile(
          title: const Center(child: Text('訂購資料', style: titleTextStyle)),
          // initiallyExpanded: true,
          children: [
            createInputRow('收件人姓名', (text) {
              context
                  .read<CheckoutBloc>()
                  .add(UpdateCheckoutEvent(fullName: text));
            }),
            createInputRow('Email', (text) {
              context
                  .read<CheckoutBloc>()
                  .add(UpdateCheckoutEvent(email: text));
            }),
            createInputRow('手機', (text) {
              context
                  .read<CheckoutBloc>()
                  .add(UpdateCheckoutEvent(phone: text));
            }),
            createInputRow('地址', (text) {
              context
                  .read<CheckoutBloc>()
                  .add(UpdateCheckoutEvent(address: text));
            }),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 80,
                    child: Text('運送時間', style: subtitleTextStyle),
                  ),
                  createRadioRow(DeliverTime.morning),
                  createRadioRow(DeliverTime.afternoon),
                  createRadioRow(DeliverTime.all),
                ],
              ),
            ),
          ],
        );
      }
      return const Text('Error');
    });
  }
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    Row createInputRow(String title, Function(String text) onChanged) {
      return Row(children: [
        SizedBox(
          width: 80,
          child: Text(title, style: subtitleTextStyle),
        ),
        horizontalSpace,
        SizedBox(
          // TextField包在Row裡面需要給固定的大小
          width: screenWidth - 150,
          child: TextFormField(
              onChanged: (value) {
                onChanged(value);
              },
              keyboardType: TextInputType.number,
              validator: (String? value) {
                return (value != null && value.isEmpty)
                    ? 'Cant bet empty'
                    : null;
              }),
        ),
      ]);
    }

    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        if (state is CheckoutLoadedState) {
          return ExpansionTile(
            title: const Center(child: Text('付款資料', style: titleTextStyle)),
            // initiallyExpanded: true,
            children: [
              createInputRow('信用卡號碼', (text) {
                context
                    .read<CheckoutBloc>()
                    .add(UpdateCheckoutEvent(cardNumber: text));
              }),
              createInputRow('到期年份', (text) {
                context
                    .read<CheckoutBloc>()
                    .add(UpdateCheckoutEvent(dueYear: text));
              }),
              createInputRow('到期月份', (text) {
                context
                    .read<CheckoutBloc>()
                    .add(UpdateCheckoutEvent(dueMonth: text));
              }),
              createInputRow('安全碼', (text) {
                context
                    .read<CheckoutBloc>()
                    .add(UpdateCheckoutEvent(ccv: text));
              }),
            ],
          );
        }
        return const Text('Error'); // 都沒有接收到的狀態
      },
    );
  }
}
