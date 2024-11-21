import 'package:flutter/cupertino.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import '../../float_inquiry/data/fi_status.dart';

FIStatus getStatus(String status, BuildContext context) {
    switch (status) {
      case "COMPLETE":
        {
          return FIStatus(
              status: "Completed", color: colors(context).positiveColor);
        }

      case "CANCELED":
        {
          return FIStatus(
              status: "Cancelled", color: colors(context).negativeColor);
        }

      case "REJECTED":
        {
          return FIStatus(
              status: "Rejected", color: colors(context).negativeColor);
        }

      case "INPROGRESS":
        {
          return FIStatus(
              status: "In Progress", color: colors(context).secondaryColor400);
        }

      case "NOTSTARTED":
        {
          return FIStatus(
              status: "Not Started", color: colors(context).secondaryColor400);
        }

      case "HOLD":
        {
          return FIStatus(status: "On Hold", color: colors(context).greyColor);
        }

      case "PENDING":
        {
          return FIStatus(status: "Pending", color: colors(context).primaryColor);
        }
      case "EXPIRED":
        {
          return FIStatus(status: "Expired", color: colors(context).greyColor);
        }
      case "ACCEPTED":
        {
          return FIStatus(status: "Accepted", color: colors(context).positiveColor);
        }
      case "SUCCESS":
        {
          return FIStatus(status: "Success", color: colors(context).positiveColor);
        }
      case "ACTIVE":
        {
          return FIStatus(status: "Pending", color: colors(context).primaryColor);
        }

      default:
        {
          return FIStatus(
              status: "Unrealized", color: colors(context).negativeColor);
        }
    }
  }
