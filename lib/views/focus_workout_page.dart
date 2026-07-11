import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '../controllers/workout_controller.dart';

class FocusWorkoutPage extends StatefulWidget {
  final String title;
  final String targetMuscle;
  final String? imageUrl;
  final String? category;

  const FocusWorkoutPage({
    super.key,
    required this.title,
    required this.targetMuscle,
    this.imageUrl,
    this.category,
  });

  @override
  State<FocusWorkoutPage> createState() => _FocusWorkoutPageState();
}

class _FocusWorkoutPageState extends State<FocusWorkoutPage> {
  List<dynamic> _exercises = [];
  bool _isLoading = true;

  // Colors based on Tailwind config
  final Color background = const Color(0xFFF8F9FF);
  final Color surface = const Color(0xFFF8F9FF);
  final Color primary = const Color(0xFF0B1C30);
  final Color onSurface = const Color(0xFF0B1C30);
  final Color onSurfaceVariant = const Color(0xFF45464D);
  final Color secondary = const Color(0xFFB61722);
  final Color onSecondary = const Color(0xFFFFFFFF);
  final Color surfaceVariant = const Color(0xFFD3E4FE);
  final Color surfaceContainerLow = const Color(0xFFEFF4FF);
  final Color outlineVariant = const Color(0xFFC6C6CD);
  final Color outline = const Color(0xFF76777D);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final controller = context.read<WorkoutController>();
    final results = await controller.fetchExercisesByMuscle(widget.targetMuscle);
    if (mounted) {
      setState(() {
        _exercises = results;
        _isLoading = false;
      });
    }
  }

  int get _totalTimeMinutes {
    // Just a rough estimate if time is not available in all exercises
    // Let's say each exercise takes about 1.5 minutes on average
    return (_exercises.length * 1.5).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Stack(
        children: [
          // Background Parallax Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: BoxDecoration(
                image: widget.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(widget.imageUrl!),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      )
                    : null,
                color: primary,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black12,
                      Colors.black54,
                    ],
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.category != null)
                      Text(
                        widget.category!,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      widget.title,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32), // Space for the rounded card overlap
                  ],
                ),
              ),
            ),
          ),

          // Scrollable Content
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: false,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.2),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.2),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                  expandedHeight: MediaQuery.of(context).size.height * 0.4 - MediaQuery.of(context).padding.top,
                  flexibleSpace: const FlexibleSpaceBar(
                    background: SizedBox(), // Handled by Stack
                  ),
                ),
                
                // Content Card
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.6 + 100, // Make sure it can scroll past bottom
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Pull Handle
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 12),
                            width: 48,
                            height: 4,
                            decoration: BoxDecoration(
                              color: outlineVariant.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        
                        // Header Details
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.title,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: surfaceContainerLow,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: outlineVariant.withOpacity(0.1)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.schedule, color: secondary, size: 20),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'DURATION',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: onSurfaceVariant,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              Text(
                                                '$_totalTimeMinutes Min',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: onSurface,
                                                  height: 1.1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: surfaceContainerLow,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: outlineVariant.withOpacity(0.1)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.format_list_bulleted, color: secondary, size: 20),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'EXERCISES',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                  color: onSurfaceVariant,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              Text(
                                                '${_exercises.length} Rounds',
                                                style: GoogleFonts.plusJakartaSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: onSurface,
                                                  height: 1.1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Exercise List
                        if (_isLoading)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(color: secondary),
                            ),
                          )
                        else if (_exercises.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Text(
                                'No exercises found.',
                                style: GoogleFonts.plusJakartaSans(color: onSurfaceVariant),
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: _exercises.map((exercise) => _buildExerciseCard(exercise)).toList(),
                            ),
                          ),

                        const SizedBox(height: 100), // Space for bottom button
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Start Workout Button Fixed at Bottom
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Handle Start Workout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starting workout...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondary,
                foregroundColor: onSecondary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
                elevation: 8,
                shadowColor: secondary.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bolt, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'START WORKOUT',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(dynamic exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: outlineVariant.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.drag_handle, color: outline.withOpacity(0.3), size: 24),
          const SizedBox(width: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              image: exercise['imageUrl'] != null
                  ? DecorationImage(
                      image: NetworkImage(exercise['imageUrl']),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: exercise['imageUrl'] == null
                ? Icon(Icons.fitness_center, color: outline.withOpacity(0.4))
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise['name'] ?? 'Unknown',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    if (exercise['time'] != null || exercise['reps'] != null) ...[
                      Icon(
                        exercise['time'] != null ? Icons.timer : Icons.repeat,
                        size: 14,
                        color: onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        exercise['time'] ?? exercise['reps'] ?? '',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 2,
                        height: 2,
                        decoration: BoxDecoration(
                          color: outlineVariant,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      (exercise['difficulty'] ?? 'Beginner').toString().capitalize(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.swap_horiz, color: outline.withOpacity(0.4), size: 24),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
