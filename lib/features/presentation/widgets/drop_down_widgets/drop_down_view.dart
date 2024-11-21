import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/utils/enums.dart';


import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../data/models/responses/city_response.dart';

import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/drop_down/drop_down_bloc.dart';
import '../../views/base_view.dart';
import '../text_fields/app_search_text_field.dart';
import '../toast_widget/toast_widget.dart';
import 'drop_down_list_item.dart';

class DropDownViewScreenArgs {
  final bool isSearchable;
  final String pageTitle;
  final DropDownEvent? dropDownEvent;
  final bool isAnEvent;
  final List<CommonDropDownResponse>? itemList;

  DropDownViewScreenArgs({
    required this.isSearchable,
    required this.pageTitle,
    this.dropDownEvent,
    this.isAnEvent = true,
    this.itemList,
  });
}

class DropDownView extends BaseView {
  final DropDownViewScreenArgs dropDownViewScreenArgs;

  DropDownView({required this.dropDownViewScreenArgs});

  @override
  _DropDownViewState createState() => _DropDownViewState();
}

class _DropDownViewState extends BaseViewState<DropDownView> {
  final _bloc = injection<DropDownBloc>();
  List<CommonDropDownResponse> allDropDownData = [];

  @override
  void initState() {
    super.initState();
    if (widget.dropDownViewScreenArgs.isAnEvent) {
      _bloc.add(widget.dropDownViewScreenArgs.dropDownEvent!);
    } else {
      allDropDownData.clear();
      allDropDownData.addAll(widget.dropDownViewScreenArgs.itemList!);
    }
  }

  @override
  Widget buildView(BuildContext context) {
    if (widget.dropDownViewScreenArgs.isAnEvent) {
      return BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<DropDownBloc, BaseState<DropDownState>>(
          listener: (context, state) {
            if (state is DropDownFailedState) {
              Navigator.of(context).pop();
              ToastUtils.showCustomToast(
                  context, state.message??"", ToastStatus.FAIL);
            }
          },
          child: AnnotatedRegion(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.dropDownViewScreenArgs.pageTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: colors(context).blackColor),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    if (widget.dropDownViewScreenArgs.isSearchable)
                      BlocBuilder<DropDownBloc, BaseState<DropDownState>>(
                        builder: (context, state) {
                          if (state is DropDownDataLoadedState) {
                            allDropDownData = state.data;
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            child: SearchTextField(
                              hintText: AppLocalizations.of(context)
                                  .translate("search"),
                              onChange: (value) {
                                _bloc.add(FilterEvent(
                                    dropDownData: allDropDownData,
                                    searchText: value));
                              },
                            ),
                          );
                        },
                      )
                    else
                      Container(),
                    BlocBuilder<DropDownBloc, BaseState<DropDownState>>(
                      builder: (context, state) {
                        if (state is DropDownFilteredState) {
                          final List<CommonDropDownResponse> data = state.data;
                          return DropDownDataLoadedContainer(
                              isSearchable:
                                  widget.dropDownViewScreenArgs.isSearchable,
                              data: data);
                        } else if (state is DropDownDataLoadedState) {
                          final List<CommonDropDownResponse> data = state.data;
                          return DropDownDataLoadedContainer(
                              isSearchable:
                                  widget.dropDownViewScreenArgs.isSearchable,
                              data: data);
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return BlocProvider(
        create: (_) => _bloc,
        child: AnnotatedRegion(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.dropDownViewScreenArgs.pageTitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: colors(context).blackColor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  if (widget.dropDownViewScreenArgs.isSearchable)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                      child: SearchTextField(
                        hintText:
                            AppLocalizations.of(context).translate("search"),
                        onChange: (value) {
                          _bloc.add(FilterEvent(
                              dropDownData: allDropDownData,
                              searchText: value));
                        },
                      ),
                    )
                  else
                    Container(),
                  BlocBuilder<DropDownBloc, BaseState<DropDownState>>(
                    builder: (context, state) {
                      if (state is DropDownFilteredState) {
                        final List<CommonDropDownResponse> data = state.data;
                        return DropDownDataLoadedContainer(
                            isSearchable:
                                widget.dropDownViewScreenArgs.isSearchable,
                            data: data);
                      } else {
                        return DropDownDataLoadedContainer(
                            isSearchable:
                                widget.dropDownViewScreenArgs.isSearchable,
                            data: allDropDownData);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

class DropDownDataLoadedContainer extends StatelessWidget {
  const DropDownDataLoadedContainer(
      {required this.isSearchable, required this.data});

  final bool isSearchable;
  final List<CommonDropDownResponse> data;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: isSearchable,
        child: RawScrollbar(
          thumbColor: colors(context).primaryColor,
          radius: const Radius.circular(10.0),
          thickness: 6,
          child: ListView.builder(
            itemCount: data.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return DropDownListItem(
                title: data[index].description ?? "-",
                onTap: () {

                  Navigator.pop(context, data[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
