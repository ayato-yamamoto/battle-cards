import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../models/card_model.dart';
import '../widgets/trading_card_widget.dart';

class CardPreviewScreen extends StatefulWidget {
  final BattleCard card;

  const CardPreviewScreen({
    super.key,
    required this.card,
  });

  @override
  State<CardPreviewScreen> createState() => _CardPreviewScreenState();
}

class _CardPreviewScreenState extends State<CardPreviewScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  bool _isSaving = false;

  Future<void> _saveCard() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final Uint8List? imageBytes = await _screenshotController.capture(
        delay: const Duration(milliseconds: 100),
        pixelRatio: 2.0,
      );

      if (imageBytes != null) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final result = await ImageGallerySaver.saveImage(
          imageBytes,
          name: 'battle_card_$timestamp',
          quality: 100,
        );

        final success = result['isSuccess'] == true;

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(success
                  ? 'カードを写真に保存しました'
                  : 'カードの保存に失敗しました'),
              backgroundColor: success ? Colors.green.shade700 : Colors.red,
              action: success
                  ? SnackBarAction(
                      label: '共有',
                      textColor: Colors.white,
                      onPressed: () => _shareCard(),
                    )
                  : null,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('カードの保存に失敗しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _shareCard([String? existingPath]) async {
    setState(() {
      _isSaving = true;
    });

    try {
      String filePath;

      if (existingPath != null) {
        filePath = existingPath;
      } else {
        final Uint8List? imageBytes = await _screenshotController.capture(
          delay: const Duration(milliseconds: 100),
          pixelRatio: 2.0,
        );

        if (imageBytes == null) {
          throw Exception('Failed to capture card image');
        }

        final directory = await getTemporaryDirectory();
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        filePath = '${directory.path}/battle_card_$timestamp.png';
        final file = File(filePath);
        await file.writeAsBytes(imageBytes);
      }

      await Share.shareXFiles(
        [XFile(filePath)],
        text: '私のバトルカード「${widget.card.name}」をチェック！',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('カードの共有に失敗しました: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text(
          'あなたのカード',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _isSaving ? null : () => _shareCard(),
            icon: const Icon(Icons.share),
            tooltip: '共有',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Screenshot(
                      controller: _screenshotController,
                      child: TradingCardWidget(
                        card: widget.card,
                        width: 300,
                        height: 420,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildCardDetails(),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildCardDetails() {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.amber.shade700,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'カード詳細',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow('名前', widget.card.name),
          _buildDetailRow('属性', widget.card.attribute.displayName),
          _buildDetailRow('レアリティ', widget.card.rarityStars),
          _buildDetailRow('攻撃力', widget.card.attack.toString()),
          _buildDetailRow('防御力', widget.card.defense.toString()),
          _buildDetailRow('HP', widget.card.hp.toString()),
          const Divider(color: Colors.grey),
          _buildDetailRow('スキル', widget.card.ability.name),
          Text(
            widget.card.ability.description,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.refresh),
                label: const Text('新しいカード'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amber.shade700,
                  side: BorderSide(color: Colors.amber.shade700, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _isSaving ? null : _saveCard,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save_alt),
                label: Text(_isSaving ? '保存中...' : 'カードを保存'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
