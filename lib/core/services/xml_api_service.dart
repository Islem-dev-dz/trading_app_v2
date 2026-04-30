import 'package:xml/xml.dart';
import 'package:flutter/foundation.dart';

class XmlApiService {
  /// Mocks sending a request and receiving an XML response
  Future<String> sendRequest(String endpoint, String payload) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    debugPrint('--- API Request to $endpoint ---');
    debugPrint(payload);

    if (endpoint == '/auth/login') {
      return _mockLoginResponse();
    } else if (endpoint == '/kyc/submit') {
      return _mockKycResponse();
    } else if (endpoint == '/market/primary') {
      return _mockPrimaryMarketResponse();
    } else if (endpoint == '/market/secondary') {
      return _mockSecondaryMarketResponse();
    } else if (endpoint == '/order/submit') {
      return _mockOrderResponse();
    } else if (endpoint == '/portfolio/summary') {
      return _mockPortfolioResponse();
    }

    return '''<?xml version="1.0" encoding="UTF-8"?>
<response>
  <status>error</status>
  <message>Unknown endpoint</message>
</response>''';
  }

  String _mockLoginResponse() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('response', nest: () {
      builder.element('status', nest: 'success');
      builder.element('token', nest: 'mock_jwt_token_123');
      builder.element('user', nest: () {
        builder.element('id', nest: 'USR-9988');
        builder.element('kycStatus', nest: 'approved'); // or pending
      });
    });
    return builder.buildDocument().toString();
  }

  String _mockKycResponse() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<response>
  <status>success</status>
  <message>KYC submitted successfully. Pending manual approval.</message>
</response>''';
  }

  String _mockPrimaryMarketResponse() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<market type="primary">
  <session>2026-04-30</session>
  <titles>
    <title>
      <isin>DZ000000001</isin>
      <name>BADR Emission 2026</name>
      <price>1000.00</price>
      <available_volume>50000</available_volume>
    </title>
  </titles>
</market>''';
  }

  String _mockSecondaryMarketResponse() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<market type="secondary">
  <session>2026-04-30</session>
  <offers>
    <offer>
      <id>OFF-101</id>
      <isin>DZ000000002</isin>
      <name>Sonatrach Actions</name>
      <type>sell</type>
      <price>2150.00</price>
      <volume>150</volume>
    </offer>
  </offers>
</market>''';
  }

  String _mockOrderResponse() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<response>
  <status>success</status>
  <orderId>ORD-999123</orderId>
  <state>active</state>
</response>''';
  }

  String _mockPortfolioResponse() {
    return '''<?xml version="1.0" encoding="UTF-8"?>
<portfolio>
  <accounts>
    <account>
      <id>ACC-ESP-01</id>
      <type>espece</type>
      <balance>500000.00</balance>
      <currency>DZD</currency>
    </account>
    <account>
      <id>ACC-TIT-01</id>
      <type>titre</type>
      <valuation>1250000.00</valuation>
    </account>
  </accounts>
</portfolio>''';
  }
}
